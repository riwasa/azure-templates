#!/bin/bash

# *****************************************************************************
#
# File:        key_vault-bicep.sh
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
resourceGroupName="<resource-group-name>"
location="<resource-group-location>"
keyVaultName="<key-vault-name>"

# Create a Key Vault.
echo "Creating a Key Vault"

az deployment group create \
  --name "key-vault" \
  --resource-group "$resourceGroupName" \
  --template-file "key_vault.bicep" \
  --parameters @"key_vault.azuredeploy.parameters.json" \
  --parameters keyVaultName="$keyVaultName" \
               location="$location"
