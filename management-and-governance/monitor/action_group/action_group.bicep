// *****************************************************************************
//
// File:        action_group.bicep
//
// Description: Creates an Action Group.
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

// The name of the Action Group.
param actionGroupName string

// The short name for the Action Group. Up to 12 characters in length.
@maxLength(12)
param actionGroupShortName string

// The e-mail address for the receiver.
param emailAddress string

// The name of the receiver.
param emailName string

resource actionGroup 'microsoft.insights/actionGroups@2019-06-01' = {
  name: actionGroupName
  location: 'Global'
  properties: {
    emailReceivers: [
      {
        emailAddress: emailAddress
        name: emailName
        useCommonAlertSchema: true
      }
    ]
    enabled: true
    groupShortName: actionGroupShortName
  }
}
