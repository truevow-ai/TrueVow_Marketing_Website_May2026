# Add chart to existing math section (don't duplicate the section)

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.chart-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Chart canvas HTML (to insert into existing section-content)
$chartHTML = @"
                <!-- INTERACTIVE CHART -->
                <div class="chart-container">
                    <canvas id="capacityChart"></canvas>
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

# Find the existing math section's section-content div
# Look for pattern: <div class="section-content"> after "Math Behind"
$mathSectionPattern = '(?s)(<h2[^>]*>.*?Math Behind.*?</h2>.*?<div class="section-content">)'
$match = [regex]::Match($content, $mathSectionPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

if ($match.Success) {
    $insertionPoint = $match.Index + $match.Length
    
    # Check if chart already exists
    if ($content -notmatch 'capacityChart') {
        # Insert chart HTML right after opening section-content div
        $content = $content.Insert($insertionPoint, "`n$chartHTML")
        Write-Host "✅ Chart canvas added to existing math section"
    } else {
        Write-Host "⚠️ Chart canvas already exists"
    }
    
    # Add chart script before closing body tag (if not already there)
    if ($content -notmatch 'new Chart.*capacityChart') {
        $bodyEnd = $content.LastIndexOf('</body>')
        if ($bodyEnd -gt 0) {
            $content = $content.Insert($bodyEnd, $chartScript)
            Write-Host "✅ Chart initialization script added"
        }
    } else {
        Write-Host "⚠️ Chart script already exists"
    }
    
    # Save with UTF-8 encoding
    $utf8NoBom = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)
    
    Write-Host "✅ Done! Chart added to existing math section."
} else {
    Write-Host "❌ Could not find existing math section. Manual fix required."
}

Write-Host "Backup saved to: $backupPath"

