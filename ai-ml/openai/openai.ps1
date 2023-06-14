# *****************************************************************************
#
# File:        openai.ps1
#
# Description: Creates an OpenAI Account.
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

# Set script variables.
$accountName = "rim-demo-oai"
$location = "francecentral"
$resourceGroupName = "rim-demo"

# Create an OpenAI Account.
Write-Host "Creating an OpenAI Account"

az deployment group create `
  --name "openai" `
  --resource-group "$resourceGroupName" `
  --template-file "openai.bicep" `
  --parameters "openai.parameters.json" `
  --parameters accountName="$accountName" `
               location="$location"