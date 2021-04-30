# *****************************************************************************
#
# File:        maps.ps1
#
# Description: Creates a Maps Account.
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

# Create a Maps Account.
New-AzResourceGroupDeployment `
  -Name "maps" `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile "$PSScriptRoot\maps.azuredeploy.json" `
	-TemplateParameterFile "$PSScriptRoot\maps.azuredeploy.parameters.json"