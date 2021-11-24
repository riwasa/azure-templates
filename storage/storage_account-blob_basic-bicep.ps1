# *****************************************************************************
#
# File:        storage_account-blob_basic-bicep.ps1
#
# Description: Creates a Storage Account, configuring blob services.
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
$storageAccountName = "<storage-account-name>"

# Create a Storage Account.
Write-Host "Creating a Storage Account"

New-AzResourceGroupDeployment `
	-Name "storage-account-blob-basic" `
	-ResourceGroupName "$resourceGroupName" `
	-TemplateFile "$PSScriptRoot\storage_account-blob_basic.bicep" `
  -TemplateParameterFile "$PSScriptRoot\storage_account-blob_basic.azuredeploy.parameters.json" `
	-storageAccountName "$storageAccountName" `
	-location "$location"
