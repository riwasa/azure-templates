#!/bin/bash

# *****************************************************************************
#
# File:        log_analytics_workspace-arm.sh
#
# Description: Creates a Log Analytics Workspace.
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
workspaceName="<log-analytics-workspace-name>"

# Create a Log Analytics Workspace.
echo "Creating a Log Analytics Workspace"

az deployment group create \
  --name "log-analytics-workspace" \
  --resource-group "$resourceGroupName" \
  --template-file "log-analytics-workspace.bicep" \
  --parameters @"log-analytics-workspace.azuredeploy.parameters.json" \
  --parameters workspaceName="$workspaceName" \
               location="$location"  
