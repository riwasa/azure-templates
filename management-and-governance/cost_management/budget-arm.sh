#!/bin/bash

# *****************************************************************************
#
# File:        budget-arm.sh
#
# Description: Creates a Budget.
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
actionGroupName="<name-of-the-action-group-to-notify>"
budgetName="<name-of-the-budget>"

# Set the start date and the end date for the budget, using a period
# from the first day of the current month to 2 years in the future.
startDate=$(date +"%Y-%m-01")
endDate=$(date -d "$startDate 2 years" +"%Y-%m-%d")

echo "Start Date: $startDate End Date: $endDate"

# Define the contact group.
actionGroupId=$(az monitor action-group show --name "$actionGroupName" --resource-group "$resourceGroupName" --output tsv --query "id")
contactGroups="['$actionGroupId']"

# Create a Budget.
echo "Creating a Budget"

az deployment group create \
  --name "budget" \
  --resource-group "$resourceGroupName" \
  --template-file "budget.azuredeploy.json" \
  --parameters @"budget.azuredeploy.parameters.json" \
  --parameters budgetName="$budgetName" \
               contactGroups="$contactGroups" \
               startDate="$startDate" \
               endDate="$endDate"
