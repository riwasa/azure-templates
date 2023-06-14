// *****************************************************************************
//
// File:        openai.bicep
//
// Description: Creates an OpenAI Account.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// *****************************************************************************

@description('The name of the OpenAI Account.')
@minLength(2)
@maxLength(64)
param accountName string

@description('The location of the resources.')
@allowed([
  'eastus'
  'francecentral'
  'uksouth'
  'westeurope'
])
param location string

@description('Indicates whether public endpoint access is allowed for this account.')
@allowed([
  'Disabled'
  'Enabled'
])
param publicNetworkAccess string

@description('The name of the SKU.')
@allowed([
  'S0'
])
param skuName string

// Create an OpenAI account.
resource account 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: accountName
  location: location
  kind: 'OpenAI'
  properties: {
    customSubDomainName: accountName
    publicNetworkAccess: publicNetworkAccess
  }
  sku: {
    name: skuName
  }
}
