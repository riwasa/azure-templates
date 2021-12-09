# *****************************************************************************
#
# File:        budget-arm.ps1
#
# Description: Creates an Action Group.
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
$actionGroupName = "<name-of-the-action-group-to-notify>"
$budgetName = "<name-of-the-budget>"

# Set the start date and the end date for the budget, using a period
# from the first day of the current month to 2 years in the future.
$startDate = Get-Date -Format "yyyy-MM-01"
$endDate = ((Get-Date).AddYears(2)).ToString("yyyy-MM-dd")

Write-Host "Start Date: $startDate EndDate: $endDate"

# Define the contact group.
$actionGroupId = (Get-AzActionGroup -Name $actionGroupName -ResourceGroupName $resourceGroupName).Id
$contactGroups="['$actionGroupId']"

# Create a Budget
Write-Host "Creating a Budget"

 New-AzResourceGroupDeployment `
 	-Name "budget" `
 	-ResourceGroupName "$resourceGroupName" `
 	-TemplateFile "$PSScriptRoot\budget.azuredeploy.json" `
  -TemplateParameterFile "$PSScriptRoot\budget.azuredeploy.parameters.json" `
  -budgetName "$budgetName" `
  -contactGroups "$contactGroups" `
  -startDate "$startDate" `
  -endDate "$endDate"