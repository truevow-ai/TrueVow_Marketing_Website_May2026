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

// 2. Copy marketing folder (HTML pages + analytics.js only)
const marketingSrc = path.join(workspaceDir, "marketing");
const marketingDst = path.join(distDir, "marketing");
fs.mkdirSync(marketingDst, { recursive: true });

let marketingItems = fs.readdirSync(marketingSrc, { withFileTypes: true });
for (let item of marketingItems) {
    let srcPath = path.join(marketingSrc, item.name);
    let destPath = path.join(marketingDst, item.name);

    if (item.isDirectory()) {
        continue;
    }
    if (item.name.endsWith(".html") || item.name === "analytics.js") {
        fs.copyFileSync(srcPath, destPath);
        console.log(`Copied marketing file: ${item.name}`);
    }
}

// 3. Copy legal folder
copyDir(path.join(workspaceDir, "legal"), path.join(distDir, "legal"));
console.log("Copied legal folder");

// 4. Copy assets folder
copyDir(path.join(workspaceDir, "assets"), path.join(distDir, "assets"));
console.log("Copied assets folder");

// 5. Copy widgets folder
copyDir(path.join(workspaceDir, "widgets"), path.join(distDir, "widgets"));
console.log("Copied widgets folder");

// 6. Setup js folder for blog content
const jsSrc = path.join(workspaceDir, "js");
const jsDst = path.join(distDir, "js");
fs.mkdirSync(jsDst, { recursive: true });

const blogJs = path.join(jsSrc, "blog-content.js");
if (fs.existsSync(blogJs)) fs.copyFileSync(blogJs, path.join(jsDst, "blog-content.js"));
console.log("Populated root js/ folder");

const marketingJsDst = path.join(marketingDst, "js");
fs.mkdirSync(marketingJsDst, { recursive: true });
if (fs.existsSync(blogJs)) fs.copyFileSync(blogJs, path.join(marketingJsDst, "blog-content.js"));
console.log("Populated marketing/js/ folder");

console.log("Success! Distribution package created at dist/");
