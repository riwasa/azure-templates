# *****************************************************************************
#
# File:        function_app.ps1
#
# Description: Creates a Function App using a Dedicated Plan.
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
$resourceGroupName = "<name-of-the-resource-group>"

$applicationInsightsName = "<name-of-the-application-insights-component>"
$appServicePlanName = "<name-of-the-app-service-plan>"
$functionAppName = "<name-of-the-function-app>"
$location = "<location-of-the-resource-group>"
$logAnalyticsName = "<name-of-the-log-analytics-workspace>"
$storageAccountName = "<name-of-the-storage-account>"

# Create a Function App.
Write-Host "Creating a Function App"

az deployment group create `
	--name "function-app" `
	--resource-group "$resourceGroupName" `
	--template-file "$PSScriptRoot\function_app.bicep" `
	--parameters "$PSScriptRoot\function_app.parameters.json" `
	--parameters `
		applicationInsightsName="$applicationInsightsName" `
		appServicePlanName="$appServicePlanName" `
		functionAppName="$functionAppName" `
		location="$location" `
		logAnalyticsName="$logAnalyticsName" `
		storageAccountName="$storageAccountName" 

# Show outputs from the Bicep script.
az deployment group show `
	--name "function-app" `
	--resource-group "$resourceGroupName" `
	--query properties.outputs.selectedRuntimeSetting.value `
	--query properties.outputs.appSettingsOutput.value 
