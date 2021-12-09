#!/bin/bash

# *****************************************************************************
#
# File:        resource_group-arm.sh
#
# Description: Creates a Resource Group.
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
deploymentName="$resourceGroupName-resource-group-$location"

# Create a Resource Group.
echo "Creating a Resource Group"

az deployment sub create \
  --name "$deploymentName" \
  --location "$location" \
  --template-file "resource-group.azuredeploy.json" \
  --parameters resourceGroupName="$resourceGroupName" \
               location="$location"