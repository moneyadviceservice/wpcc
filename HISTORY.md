## 2.0.0

* Tax year changes for April 2018
* Refactor wpcc config yaml files
* Refactor javascript to be flexible with the threshold values that changes
each year.

## 1.14

* Refactoring settings to use a yaml file (including Javascript).

## 1.13.2:
* Updates Brakeman gem to version 4.1.1

## 1.13.0:
* TP-8618 Add 'near threshold' warnings when user salary is close

## 1.12.1:
* TP-8694 Adds visually hidden table heading for accessibility

## 1.12.0:
* Adds Dough helpers across all views for tooltips

## 1.11.14:
* Bumps version for accessibility updates

## 1.11.13:
* TP-8686: Adds field label for salary frequency
* TP-8687: Adds labels to contribution inputs
* TP-8689: Adds labels to contribution frequency
* TP-8693: Adds more descriptive step header edit links
* TP-8692: Sets pahe meta titles per step in process

## 1.11.12:
* TP-8634: Fix missing tooltip trigger for step 2 in Welsh

## 1.11.5:
* Switch build process to Jenkins

## 1.11.4:
* TP-8601: Fix increasing employer contributions

Refactors:
* Update javascript cucumber features to stop race condition
* Update test script to reduce noise on command line when running
* Add Docker and Jenkins

## 1.11.3:
* Fixing Karma tests

## 1.11.2:
* TP-8580: Fixing the double dropdown issue

## 1.11.1:
* TP-8572: Making reference links within WPCC to be opened in new tab

## 1.11.0:
* TP-8565: Amend the employer percent for calculating contributions
* TP-8564: Add server side validations for contribution percent

## 1.10.0:
* TP-8568: Adds meta title description and canonical

## 1.9.2:
* Refactors data attributes for internal components

## 1.9.1:
* TP-8556: Fixes Popuptips and div floating issue in step 1

## 1.9.0
* TP-8541: Add conditional intro text to results page
* TP-8555: Amend salary tooltip url
* TP-8554: Add url link to tax relief guide

## 1.8.2
* TP-8458: Fix validation message
* TP-8552: Fix Client side salary validation bugs

## 1.8.1
* TP-8526: Display correct frequency titles in results
* TP-8531: Amend Salary label and tooltip

Refactors:
* Fix Grammar

## 1.8.0
* TP-8213: Add email component
* TP-8532: Add launch warning

## 1.7.1
* TP-8408: Reset the calculator

Refactors:
* Tidies the mark up

## 1.7.0

* TP-8439: Dynamically update values on results page
* TP-8522: Fix contribution conditional messaging
* TP-8513: Fix edit details salary frequency bug
* TP-8506: Display messages based on contribution percents
* TP-8520: Results page links and welsh text in views
* TP-8507: Display frequency in results table headings
* TP-8458: Adds server side validation for the age field
* TP-8524: Format numbers

Refactors:
* Fix issue with global nav not being full width

## 1.6.0

* TP-8505: Fixes bug on Step 1 re salary/contributions inputs
* TP-8472: Conditional messaging for step 2
* TP-8492: Step 2, updates percent boxes
* TP-8491: Updates copy in the results page
* TP-8448: Session expired redirect
* TP-8492: Step 3, updates percent boxes
* TP-8471: step 1 updates
* TP-8434: Information table of annual percents
* TP-8477: Display the salary below threshold callout message
* TP-8459: Select 'full salary' contribution preference

## 1.5.1

* Fix welsh translation missing errors.

## 1.5.0

* TP-8447: Calculate yearly contributions results by monthly salary equivalent
* TP-8473: Set minimum contribution as default
* TP-8407: Limit tax relief when yearly contributions above £40,000.
* TP-8469: Step 1 enhancements
* TP-8214: Print results feature
* TP-8426: Amendments to tax relief warning
* TP-8449: Add eligible salary contribution conditional message
* TP-8445: Refactor cucumber steps
* TP-8427: Opt in message for users earning between 5876 and 10,000 inclusive
* TP-8426: Display warning message when salary is below £11,500
* TP-8302: Display same results for contributions above the legal minimum
* TP-8406: Add a frequency selector on last step
* TP-8438: Client side validation for step 2
* Updating Dough
* Add git pre-push hook
* Add logger message to period contribution calculator

## 1.4.0

* TP-8284: Add Test for full pay contribution scenario

Refactors:
* Editing yourDetails
* Move some of YourContributions view into partial

## 1.3.0

* TP-8411: Add Karma to WPCC
* TP-8207: Update markup and styles for 3rd view
* TP-8287: Return to Step 2 to edit your contributions
* TP-8286: Fix contribution values '(You: x%, Your employer: x%)' information
* Format the period date to be readable

Refactors:
* Remove active model require all over the place
* Remove your details session fetch & Assign to form object

## 1.2.0

* Publish first working version of gem
