# Add chart canvas to existing math section (don't duplicate anything)

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.chart-fix-backup"

Write-Host "Reading file..."
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

# Check if chart canvas already exists
if ($content -match 'id="capacityChart"') {
    Write-Host "Chart canvas already exists - checking if it's in the right place..."
    
    # Check if it's in the math section
    $mathIndex = $content.IndexOf('Math Behind')
    $chartIndex = $content.IndexOf('capacityChart')
    
    if ($mathIndex -gt 0 -and $chartIndex -gt 0 -and $chartIndex -gt $mathIndex -and ($chartIndex - $mathIndex) -lt 5000) {
        Write-Host "Chart is already in math section - script should be there too"
    } else {
        Write-Host "Chart exists but may not be in math section - will add to math section"
    }
} else {
    Write-Host "Chart canvas not found - adding it to math section..."
    
    # Find the math section's section-content div
    # Pattern: "Math Behind" followed by section-content div
    $pattern = '(?s)(Math Behind[^<]*</h2>[^<]*<div[^>]*class="section-content"[^>]*>)'
    $match = [regex]::Match($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($match.Success) {
        $insertionPoint = $match.Index + $match.Length
        $content = $content.Insert($insertionPoint, "`n$chartHTML")
        Write-Host "Chart canvas added to existing math section"
    } else {
        # Try simpler pattern
        $simplePattern = '(?s)(<div[^>]*class="section-content"[^>]*>)(?=.*Math Behind)'
        $simpleMatch = [regex]::Match($content, $simplePattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        
        if ($simpleMatch.Success) {
            $insertionPoint = $simpleMatch.Index + $simpleMatch.Length
            $content = $content.Insert($insertionPoint, "`n$chartHTML")
            Write-Host "Chart canvas added to section-content"
        } else {
            Write-Host "Could not find section-content in math section - trying alternative approach"
            # Find "Math Behind" and look for next section-content after it
            $mathPos = $content.IndexOf('Math Behind')
            if ($mathPos -gt 0) {
                $afterMath = $content.Substring($mathPos)
                $sectionContentPos = $afterMath.IndexOf('class="section-content"')
                if ($sectionContentPos -gt 0) {
                    $sectionContentEnd = $afterMath.IndexOf('>', $sectionContentPos) + 1
                    $insertionPoint = $mathPos + $sectionContentPos + $sectionContentEnd
                    $content = $content.Insert($insertionPoint, "`n$chartHTML")
                    Write-Host "Chart canvas added using alternative method"
                }
            }
        }
    }
}

# Add chart script if not already there
if ($content -notmatch 'new Chart.*capacityChart') {
    $bodyEnd = $content.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $content = $content.Insert($bodyEnd, $chartScript)
        Write-Host "Chart initialization script added"
    }
} else {
    Write-Host "Chart script already exists"
}

# Save with UTF-8 encoding
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! File saved."
Write-Host "Backup saved to: $backupPath"

