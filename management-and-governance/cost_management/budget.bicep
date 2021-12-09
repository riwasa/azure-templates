// *****************************************************************************
//
// File:        budget.bicep
//
// Description: Creates a Budget.
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

// The name of the Budget.
param budgetName string

// The total amount of cost or usage to track.
param amount int

// The list of e-mail addresses to send the notifications to.
param contactEmails array = []

// The list of Action Groups to send the notifications to.
param contactGroups array = []

// The list of roles to send the notifications to.
param contactRoles array = []

// The threshold for the first notification. Percentage between 0 and 1000.
param firstThreshold int

// The threshold for the second notification. Percentage between 0 and 1000.
param secondThreshold int

// The start date for the budget as the first of the month in YYYY-MM-DD format. 
// Future start date should not be more than three months. Past start date should be selected within the timegrain period.
param startDate string

// The end date for the budget in YYYY-MM-DD format. If not provided, this is defaulted to 10 years from the start date.
param endDate string

// The time covered by the Budget. Tracking will be reset based on the time grain.
@allowed([
  'Monthly'
  'Quarterly'
  'Annually'
])
param timeGrain string = 'Monthly'

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: budgetName
  properties: {
    amount: amount
    category: 'Cost'
    notifications: {
      NotificationForExceededBudget1: {
        contactEmails: contactEmails
        contactGroups: contactGroups
        contactRoles: contactRoles
        enabled: true
        operator: 'GreaterThan'
        threshold: firstThreshold
      }
      NotificationForExceededBudget2: {
        contactEmails: contactEmails
        contactGroups: contactGroups
        contactRoles: contactRoles
        enabled: true
        operator: 'GreaterThan'
        threshold: secondThreshold
      }
    }
    timeGrain: timeGrain
    timePeriod: {
      startDate: startDate
      endDate: endDate
    }
  }
}
