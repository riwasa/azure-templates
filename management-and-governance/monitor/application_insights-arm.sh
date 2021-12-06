#!/bin/bash

# *****************************************************************************
#
# File:        application_insights-arm.sh
#
# Description: Creates an Application Insights Component.
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
applicationInsightsName="<application-insights-component-name>"
logAnalyticsName="<log-analytics-workspace-name>"

# Create an Application Insights Component.
echo "Creating an Application Insights Component"

az deployment group create \
  --name "application-insights" \
  --resource-group "$resourceGroupName" \
  --template-file "application_insights.azuredeploy.json" \
  --parameters @"application_insights.azuredeploy.parameters.json" \
  --parameters applicationInsightsName="$applicationInsightsName" \
               logAnalyticsName="$logAnalyticsName" \
               location="$location"  
