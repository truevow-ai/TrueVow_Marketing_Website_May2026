# Fix Missing Math Section in county-cap.html

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.math-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Math section HTML content
$mathSectionHTML = @"
            <h2 class="section-title">
                <span class="section-icon">📊</span>
                The Math Behind 33%
            </h2>
            <div class="section-content">
                <!-- INTERACTIVE CHART -->
                <div class="chart-container">
                    <canvas id="capacityChart"></canvas>
                </div>
                
                <table class="capacity-table">
                    <thead>
                        <tr>
                            <th>Market Penetration</th>
                            <th>Your Cases/Month</th>
                            <th>Advantage vs. Baseline</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>10%</strong> have TrueVow</td>
                            <td>4.8</td>
                            <td><strong style="color: #2E7D32;">+92% ✅</strong></td>
                        </tr>
                        <tr>
                            <td><strong>20%</strong> have TrueVow</td>
                            <td>4.2</td>
                            <td><strong style="color: #2E7D32;">+68% ✅</strong></td>
                        </tr>
                        <tr style="background: #E8F4FD;">
                            <td><strong>33%</strong> have TrueVow (OUR CAP)</td>
                            <td>3.7</td>
                            <td><strong style="color: #0A2463;">+48% ✅ SWEET SPOT!</strong></td>
                        </tr>
                        <tr>
                            <td><strong>50%</strong> have TrueVow</td>
                            <td>3.2</td>
                            <td><strong style="color: #F57C00;">+28% ⚠️</strong></td>
                        </tr>
                        <tr>
                            <td><strong>100%</strong> have TrueVow</td>
                            <td>2.5</td>
                            <td><strong style="color: #C62828;">0% ❌ No Advantage</strong></td>
                        </tr>
                    </tbody>
                </table>
                
                <div class="highlight-box">
                    <strong>Why 33% is optimal:</strong> Strong competitive edge + sustainable growth + ethical market stewardship.
                </div>
            </div>
"@

# Chart.js initialization script
$chartScript = @"
        <script>
            // Initialize capacity chart when page loads
            document.addEventListener('DOMContentLoaded', function() {
                const ctx = document.getElementById('capacityChart');
                if (ctx) {
                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: ['10%', '20%', '33%', '50%', '100%'],
                            datasets: [{
                                label: 'Your Cases/Month',
                                data: [4.8, 4.2, 3.7, 3.2, 2.5],
                                borderColor: '#0A2463',
                                backgroundColor: 'rgba(10, 36, 99, 0.1)',
                                tension: 0.4,
                                fill: true
                            }, {
                                label: 'Baseline (No TrueVow)',
                                data: [2.5, 2.5, 2.5, 2.5, 2.5],
                                borderColor: '#C62828',
                                borderDash: [5, 5],
                                backgroundColor: 'rgba(198, 40, 40, 0.1)',
                                fill: true
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: true,
                            plugins: {
                                title: {
                                    display: true,
                                    text: 'Market Penetration vs. Your Competitive Advantage',
                                    font: {
                                        size: 18,
                                        weight: 'bold'
                                    }
                                },
                                legend: {
                                    display: true,
                                    position: 'top'
                                }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    max: 5,
                                    title: {
                                        display: true,
                                        text: 'Cases per Month'
                                    }
                                },
                                x: {
                                    title: {
                                        display: true,
                                        text: 'Market Penetration'
                                    }
                                }
                            }
                        }
                    });
                }
            });
        </script>
"@

# Find where to insert the math section
# Look for closing </section> tags or specific markers
$insertAfter = '</section>'
$insertBefore = '<section'

# Try to find a good insertion point - after hero section or before FAQ
$insertionPoint = -1

# Look for common section markers
if ($content -match 'hero.*?</section>') {
    $insertionPoint = $content.IndexOf($matches[0]) + $matches[0].Length
    Write-Host "Found insertion point after hero section"
} elseif ($content -match '</section>') {
    $firstSectionEnd = $content.IndexOf('</section>')
    $insertionPoint = $firstSectionEnd + '</section>'.Length
    Write-Host "Found insertion point after first section"
} else {
    # Insert before closing body tag
    $insertionPoint = $content.LastIndexOf('</body>')
    Write-Host "Inserting before closing body tag"
}

if ($insertionPoint -gt 0) {
    # Insert the math section
    $newContent = $content.Insert($insertionPoint, "`n        <section class=`"section`">`n$mathSectionHTML`n        </section>`n")
    
    # Add chart script before closing body tag
    $bodyEnd = $newContent.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $newContent = $newContent.Insert($bodyEnd, $chartScript)
    }
    
    # Save with UTF-8 encoding
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($filePath, $newContent, $utf8NoBom)
    
    Write-Host "✅ Math section added successfully!"
} else {
    Write-Host "❌ Could not find insertion point. Manual fix required."
}

Write-Host "Backup saved to: $backupPath"

