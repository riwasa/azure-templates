#!/bin/bash

# *****************************************************************************
#
# File:        storage_account-blob_files-bicep.sh
#
# Description: Creates a Storage Account, configuring blob and basic file
#              services.
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
storageAccountName="<storage-account-name>"

# Create a Storage Account.
echo "Creating a Storage Account"

az deployment group create \
  --name "storage-account-blob-files" \
  --resource-group "$resourceGroupName" \
  --template-file "storage_account-blob_files.bicep" \
  --parameters @"storage_account-blob_files.azuredeploy.parameters.json" \
  --parameters storageAccountName="$storageAccountName" \
               location="$location"
