# *****************************************************************************
#
# File:        action_group-arm.ps1
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
$actionGroupName = "<name-of-action-group>"
$actionGroupShortName = "<short-name-of-action-group>"
$emailAddress = "<email-address-of-person-to-notify>"
$emailName = "<name-of-person-to-notify>"

# Create an Action Group.
Write-Host "Creating an Action Group"

New-AzResourceGroupDeployment `
	-Name "action-group" `
	-ResourceGroupName "$resourceGroupName" `
	-TemplateFile "$PSScriptRoot\action_group.azuredeploy.json" `
  -actionGroupName "$actionGroupName" `
  -actionGroupShortName "$actionGroupShortName" `
  -emailAddress "$emailAddress" `
  -emailName "$emailName"