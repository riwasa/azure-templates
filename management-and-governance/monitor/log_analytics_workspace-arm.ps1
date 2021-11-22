# *****************************************************************************
#
# File:        log_analytics_workspace-arm.ps1
#
# Description: Creates a Log Analytics Workspace.
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
$workspaceName = "<log-analytics-workspace-name>"

# Create a Log Analytics Workspace.
Write-Host "Creating a Log Analytics Workspace"

New-AzResourceGroupDeployment `
	-Name "log-analytics-workspace" `
	-ResourceGroupName "$resourceGroupName" `
	-TemplateFile "$PSScriptRoot\log-analytics-workspace.azuredeploy.json" `
  -TemplateParameterFile "$PSScriptRoot\log-analytics-workspace.azuredeploy.parameters.json" `
	-workspaceName "$workspaceName" `
	-location "$location"
