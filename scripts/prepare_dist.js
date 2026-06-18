const fs = require('fs');
const path = require('path');

const workspaceDir = path.resolve(__dirname, '..');
const distDir = path.join(workspaceDir, 'dist');

console.log("Preparing distribution package...");

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

// Cleanup dist if exists
if (fs.existsSync(distDir)) {
    fs.rmSync(distDir, { recursive: true, force: true });
}
fs.mkdirSync(distDir, { recursive: true });

// 1. Copy root redirect files
fs.copyFileSync(path.join(workspaceDir, "apply.html"), path.join(distDir, "apply.html"));
fs.copyFileSync(path.join(workspaceDir, "index.html"), path.join(distDir, "index.html"));
console.log("Copied root redirect files");

// 2. Copy marketing folder (excluding archive, backups, drafts, etc.)
const marketingSrc = path.join(workspaceDir, "marketing");
const marketingDst = path.join(distDir, "marketing");
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
copyDir(path.join(workspaceDir, "legal"), path.join(distDir, "legal"));
console.log("Copied legal folder");

// 4. Copy assets folder
copyDir(path.join(workspaceDir, "assets"), path.join(distDir, "assets"));
console.log("Copied assets folder");

// 5. Copy components folder (excluding components/admin)
const componentsSrc = path.join(workspaceDir, "components");
const componentsDst = path.join(distDir, "components");
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
copyDir(path.join(workspaceDir, "widgets"), path.join(distDir, "widgets"));
console.log("Copied widgets folder");

// 7. Setup combined js folder (at root) and marketing/js folder
const jsSrc = path.join(workspaceDir, "js");
const jsDst = path.join(distDir, "js");
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

console.log("Success! Distribution package created at dist/");
