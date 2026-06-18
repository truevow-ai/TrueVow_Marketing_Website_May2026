const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const workspaceDir = "D:\\truevow\\TrueVow_Marketing_Website_May2026";
const tempDir = path.join(workspaceDir, "temp_deploy");
const zipPath = path.join(workspaceDir, "deploy.zip");

console.log("Building deployment package...");

// Helper to copy directory recursively
function copyDir(src, dest) {
    fs.mkdirSync(dest, { recursive: true });
    let entries = fs.readdirSync(src, { withFileTypes: true });

    for (let entry of entries) {
        let srcPath = path.join(src, entry.name);
        let destPath = path.join(dest, entry.name);

        if (entry.isDirectory()) {
            copyDir(srcPath, destPath);
        } else {
            fs.copyFileSync(srcPath, destPath);
        }
    }
}

// Cleanup temp_deploy and zip if exists
if (fs.existsSync(tempDir)) {
    fs.rmSync(tempDir, { recursive: true, force: true });
}
if (fs.existsSync(zipPath)) {
    fs.rmSync(zipPath, { force: true });
}
fs.mkdirSync(tempDir, { recursive: true });

// 1. Copy root redirect files
fs.copyFileSync(path.join(workspaceDir, "apply.html"), path.join(tempDir, "apply.html"));
fs.copyFileSync(path.join(workspaceDir, "index.html"), path.join(tempDir, "index.html"));
console.log("Copied root redirect files");

// 2. Copy marketing folder (excluding archive, backups, etc.)
const marketingSrc = path.join(workspaceDir, "marketing");
const marketingDst = path.join(tempDir, "marketing");
fs.mkdirSync(marketingDst, { recursive: true });

let marketingItems = fs.readdirSync(marketingSrc, { withFileTypes: true });
for (let item of marketingItems) {
    let srcPath = path.join(marketingSrc, item.name);
    let destPath = path.join(marketingDst, item.name);

    if (item.name === "archive" || item.name.includes("backup") || (item.name.includes("draft") && item.name !== "draft.html") || item.name === "js") {
        continue;
    }

    if (item.isDirectory()) {
        copyDir(srcPath, destPath);
    } else {
        if (item.name.endsWith(".html") || item.name === "analytics.js") {
            fs.copyFileSync(srcPath, destPath);
            console.log(`Copied marketing file: ${item.name}`);
        }
    }
}

// 3. Copy legal folder
copyDir(path.join(workspaceDir, "legal"), path.join(tempDir, "legal"));
console.log("Copied legal folder");

// 4. Copy assets folder
copyDir(path.join(workspaceDir, "assets"), path.join(tempDir, "assets"));
console.log("Copied assets folder");

// 5. Copy components folder (excluding components/admin)
const componentsSrc = path.join(workspaceDir, "components");
const componentsDst = path.join(tempDir, "components");
fs.mkdirSync(componentsDst, { recursive: true });
let componentsItems = fs.readdirSync(componentsSrc, { withFileTypes: true });
for (let item of componentsItems) {
    if (item.name === "admin") continue;
    let srcPath = path.join(componentsSrc, item.name);
    let destPath = path.join(componentsDst, item.name);
    if (item.isDirectory()) {
        copyDir(srcPath, destPath);
    } else {
        fs.copyFileSync(srcPath, destPath);
    }
}
console.log("Copied components folder (excluding admin)");

// 6. Copy widgets folder
copyDir(path.join(workspaceDir, "widgets"), path.join(tempDir, "widgets"));
console.log("Copied widgets folder");

// 7. Setup combined js folder (at root) and marketing/js folder
const jsSrc = path.join(workspaceDir, "js");
const jsDst = path.join(tempDir, "js");
fs.mkdirSync(jsDst, { recursive: true });

const blogJs = path.join(jsSrc, "blog-content.js");
const loadJs = path.join(jsSrc, "load-components.js");
const countyJs = path.join(marketingSrc, "js", "county-cap-search.js");

if (fs.existsSync(blogJs)) fs.copyFileSync(blogJs, path.join(jsDst, "blog-content.js"));
if (fs.existsSync(loadJs)) fs.copyFileSync(loadJs, path.join(jsDst, "load-components.js"));
if (fs.existsSync(countyJs)) fs.copyFileSync(countyJs, path.join(jsDst, "county-cap-search.js"));
console.log("Populated root js/ folder");

const marketingJsDst = path.join(marketingDst, "js");
fs.mkdirSync(marketingJsDst, { recursive: true });
if (fs.existsSync(blogJs)) fs.copyFileSync(blogJs, path.join(marketingJsDst, "blog-content.js"));
if (fs.existsSync(loadJs)) fs.copyFileSync(loadJs, path.join(marketingJsDst, "load-components.js"));
if (fs.existsSync(countyJs)) fs.copyFileSync(countyJs, path.join(marketingJsDst, "county-cap-search.js"));
console.log("Populated marketing/js/ folder");

// 8. Create zip file using PowerShell Compress-Archive
console.log("Zipping deploy package using PowerShell...");
try {
    execSync(`powershell -Command "Compress-Archive -Path temp_deploy\\* -DestinationPath deploy.zip -Force"`, { stdio: 'inherit' });
    console.log("Zipping complete!");
} catch (err) {
    console.error("Zipping failed:", err);
}

// Cleanup temp_deploy
fs.rmSync(tempDir, { recursive: true, force: true });
console.log("Success! Deployment package created at deploy.zip");
