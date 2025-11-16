# Final fix: Ensure ONE math section with chart (no duplicates)

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.final-fix-backup"

Write-Host "Reading current file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Chart canvas HTML
$chartHTML = @"
                <!-- INTERACTIVE CHART -->
                <div class="chart-container">
                    <canvas id="capacityChart"></canvas>
                </div>
                
"@

# Chart.js script
$chartScript = @"
        <script>
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
                                    font: { size: 18, weight: 'bold' }
                                },
                                legend: { display: true, position: 'top' }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    max: 5,
                                    title: { display: true, text: 'Cases per Month' }
                                },
                                x: {
                                    title: { display: true, text: 'Market Penetration' }
                                }
                            }
                        }
                    });
                }
            });
        </script>
"@

# Check current state
$hasMathSection = $content -match 'Math Behind|33%'
$hasChart = $content -match 'capacityChart'
$hasChartScript = $content -match 'new Chart.*capacityChart'

Write-Host "Current state:"
Write-Host "  Math section exists: $hasMathSection"
Write-Host "  Chart canvas exists: $hasChart"
Write-Host "  Chart script exists: $hasChartScript"

# If math section exists but chart doesn't, add it
if ($hasMathSection -and -not $hasChart) {
    Write-Host "`nAdding chart to existing math section..."
    
    # Find "Math Behind" or "33%" section
    $mathPattern = '(?s)(Math Behind[^<]*</h2>[^<]*<div[^>]*class="section-content"[^>]*>)'
    $match = [regex]::Match($content, $mathPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($match.Success) {
        $insertionPoint = $match.Index + $match.Length
        $content = $content.Insert($insertionPoint, "`n$chartHTML")
        Write-Host "Chart canvas added"
    } else {
        # Try finding section-content near "33%"
        $mathPos = $content.IndexOf('33%')
        if ($mathPos -gt 0) {
            $after33 = $content.Substring($mathPos, 2000)
            $sectionContentPos = $after33.IndexOf('class="section-content"')
            if ($sectionContentPos -gt 0) {
                $divEnd = $after33.IndexOf('>', $sectionContentPos) + 1
                $insertionPoint = $mathPos + $sectionContentPos + $divEnd
                $content = $content.Insert($insertionPoint, "`n$chartHTML")
                Write-Host "Chart canvas added (alternative method)"
            }
        }
    }
}

# Add chart script if missing
if (-not $hasChartScript) {
    $bodyEnd = $content.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $content = $content.Insert($bodyEnd, $chartScript)
        Write-Host "Chart script added"
    }
}

# Save with UTF-8 encoding
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "`nDone! File saved."
Write-Host "Backup: $backupPath"

