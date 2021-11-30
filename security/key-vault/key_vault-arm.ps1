# *****************************************************************************
#
# File:        key_vault-arm.ps1
#
# Description: Creates a Key Vault.
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
$resourceGroupName="<resource-group-name>"
$location="<resource-group-location>"
$keyVaultName="<key-vault-name>"

# Create a Key Vault.
Write-Host "Creating a Key Vault"

New-AzResourceGroupDeployment `
	-Name "key-vault" `
	-ResourceGroupName "$resourceGroupName" `
	-TemplateFile "$PSScriptRoot\key_vault.azuredeploy.json" `
  -TemplateParameterFile "$PSScriptRoot\key_vault.azuredeploy.parameters.json" `
	-keyVaultName "$keyVaultName" `
	-location "$location"
