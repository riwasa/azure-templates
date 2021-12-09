# *****************************************************************************
#
# File:        application_insights-arm.ps1
#
# Description: Creates an Application Insights Component.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# *****************************************************************************

# Get script variables.
$resourceGroupName = "<resource-group-name>"
$location = "<resource-group-location>"
$applicationInsightsName = "<application-insights-component-name>"
$logAnalyticsName = "<log-analytics-workspace-name>"

# Create an Application Insights Component.
Write-Host "Creating an Application Insights Component"

New-AzResourceGroupDeployment `
	-Name "application-insights" `
	-ResourceGroupName "$resourceGroupName" `
	-TemplateFile "$PSScriptRoot\application_insights.azuredeploy.json" `
  -TemplateParameterFile "$PSScriptRoot\application_insights.azuredeploy.parameters.json" `
	-applicationInsightsName "$applicationInsightsName" `
	-logAnalyticsName "$logAnalyticsName" `
	-location "$location"
