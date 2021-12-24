# Development Workflow

## Workflow Overview

This guide provides information about:

* Cleaning and setup
* New sprints, iterations or particular features
* Prepare release code base
* Update working branches after release
* Add fixes or hot-fixes on release and master branches

## Clean local workspace

Before getting start to work on an issue as a developer you need to ensure that your local repository is up to date.

First, is necessary to update your *develop* branch to match remote changes.

```shell
git checkout develop
```

```shell
git fetch origin
```

```shell
git pull origin develop
```

Finally, you must clean remote references to branches:

```shell
git remote prune origin
```

For more information about the last command, we recommend to check [this thread](http://stackoverflow.com/questions/4040717/git-remote-prune-didnt-show-as-many-pruned-branches-as-i-expected).

## Work on an Issue (New features)

### Analyze the issue

After getting issues assigned, to work on an issue you must review the issue assigned to you, understand it and ask if there are any questions.

* If there is any question, you need to write a comment on the issue thread
  mentioning the current issue administrator or reporter.
* Wait for the clarifications.

### About branch naming

#### Types

In general the first part of your branch name should match the type of task your working on followed by the `/` character:

* chore
* feature
* fix
* refactor
* hotfix

Examples:

* `chore/task-id/gradle-dependencies`
* `feature/task-id/recurrent-loans-view`
* `fix/task-id/login-flow`
* `refactor/task-id/calculator-base`
* `hotfix-1.0.1/task-id/user-login-redirection`

#### Development process

Depending on the development process you might end up working on:

* alpha releases
* beta releases
* production releases

When working with `alpha/` or `beta/` releases you must add a prefix for your any branch:

* `alpha/fix/login-flow`
* `alpha/refactor/calculator-base`
* `beta/feature/recurrent-loans-view`
* etc...

### Create a working branch

#### More naming information

In general, the name of the working branch needs to match:

* The issue identifier (Optional)
* The task title

Please follow the next **nomenclature**:

```shell
[type]/[issue-id]/[issue-short-description]
```

**Where:**

* **issueid (Optional):** Is the identifier assigned by the platform where the administrator created the issue. Depending on the project software configuration this issue could be the reference to another identifier.
* **a-issue-title:** This value references the title field on the issue created on the software version control platform. Depending on the project software configuration this title may change.

*Examples of working branches names:*

* `feature/ENSO-101/edit-flowmeter`
* `fix/ENSO-102/review-client-information-display`
* etc...

#### Process

When you are ready to work on the issue, you need to create a new branch.

As a developer you need to create a local branch using the nomenclature defined at the beginning of this section and push it to the remote repository. *It is important that the branch starts from the develop remote reference.*

```shell
git fetch origin && git checkout develop
```

```shell
git checkout -b [type]/[issue-id]/[issue-short-description]
```

```shell
git push origin [type]/[issue-id]/[issue-short-description]
```

After the working branch is ready, you must make the proper changes and push your to work to the remote repository.

### Commit messages

In order to achieve traceability between commits, branches and issues, commit messages should include the following information

```shell
[JIRA-ID][COMPONENT] Description
```
*Examples of commit messages:*

* `[ENSO-101] [iOS] edit flowmeter`
* `[ENSO-101] [iOS] review client information display`
* etc...

### Request Issue Review

When the developer has finished working on the assigned issue, and his working branch is already pushed to the remote repository, he needs to create a Pull Request (PR) from his working branch to *develop* branch and assign the administrator as a reviewer of the PR.

Inside the Pull Request description the developer can specify if the reviewer needs to read any comments made on the working branch commits. Please use the following template for your pull request description:

```markdown
# What’s this PR do?

- Topic 1
- Topic 2
- Topic 3

# Does this add new dependencies? Is there an installation procedure?
n/a

# How should this be manually tested?
n/a

# Screenshots
n/a

# Who should review this PR?

```

## Prepare release code base

### Semantic Version

#### View Existing Values

We can view current version number using the following command
```shell
xcrun agvtool what-marketing-version
```

We can view current build number using the following command
```shell
$ xcrun agvtool what-version
```

#### Update to Next Version
We can update the value to next version number using the following command
```shell
$ xcrun agvtool new-marketing-version 2.0
```

We can increment build number to next build number using the following command
```shell
$ xcrun agvtool next-version -all

```

We can also specify the specific value of the build number using the command. e.g we want build number to 3.2 then we can do that with the following command
```shell
$ xcrun agvtool new-version -all 3.2
```


Now it's time to prepare our app to be deployed to our users.

### 1. Create a `release` branch

```shell
git checkout -b release-X.X.X develop
```

### 2. Make release adjustments and last fixes

### 3. Update relase notes

Open the file [Release Notes](./RELEASE_NOTES.md):

1. Move the current version under the section `Last Updates` as the first element under the section `Updates History`.
2. Now, under the `Last Updates` use the following structure to add the new version info:

```markdown
## Last Updates

### Version: X.X.X (<Month> <Year>)

#### HotFixes

* No new hotfixes in this release.

#### Notable Info

* <Info 1>
* <Info 2>

## Updates History

### Version: X.X.X (<Month> <Year>)

Tag name: `<Add tag name>`. (Optional tag name)

<Add version description here>.

#### Features

* <Feautre 1>
* <Feautre 2>

#### BugFixes

* No new bugfixes in this release.

#### HotFixes

* No new hotfixes in this release.

#### Notable Info

* <Info 1>
* <Info 2>

* No info in this release.
```

### 4. Merge `release` branch to `master` through a Pull Request

### 5. Tag the last commit which points to code base to be released

```shell
git tag -a vX.X.X -m "Enter here your description for this release"
```

Example:

```shell
git tag -a v1.0.6 -m "Alpha release includes welcome, onboarding and contacts features"
```

### 6. Update `develop` for further work

```shell
git checkout develop && git merge master
```

Finally, update the remote develop branch

```shell
git push origin develop
```

## Deal With Hot-Fixes

From time to time the application in production may need to be maintained because of crash reports.

When the error occurs on a production version a developer need to fix the version starting from the `master` branch and naming his hot-fix branch with the following nomenclature:

```shell
hotfix-0.0.0/a-fix-title
```

Where:

* **hotfix:** Is the main identifier that the branch is a hot-fix from a release version on production stage.
* **0-0-0:** This value references the **next version to be deployed to production when the hot-fix is approved**. We use [Semantic Versioning 2.0.0](http://semver.org/) so in this case we only need to increment the PATCH part of the version.
* **a-fix-title:** This value references the title field on the issue created on the software version control platform. Depending on the project software configuration this title may change.

*Examples of hot-fix branches names:*

* `hotfix-1.6.2/login-error` (When the hotfix is applied to the current version 1.6.1 on production)
* `hotfix-1.0.1/networking-messages` (When the hotfix is applied to the current version 1.0.0 on production)
* etc...
