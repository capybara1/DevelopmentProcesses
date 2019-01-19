# Version Control

## Branching

Considerations:
- Using branches increases the risk of merge conflicts which might cause overhead (conflict resolution, testing, ...)
- Using branches decreases the risk of unwanted side-effects by creating isolation

### Categories

#### *Master* (Branch)

- Also known as *trunk* or *main(line)*
- Usually the *master* provides the latest changes
- Anything in the master branch is always deployable

#### Development Branch

Comparison to other Categories:
- Long-Lived multi-purpose branch (feature development, bugfixing, integration, ...)

Purpose:
- Maintains and protects a stable *master*
- Allows collaboration for a small amount of units (teams, ...)

Lifetime:
- Long-Lived
  - Created right after creation fo the repository
  - Indefinite life-span

Rules:
- Integrate in both directions on a regular basis

Disadvantages:
- Does not scale well

#### Feature Branches

Compared to other Categories:
- Specialized, short-lived derivation of Development Branch

Purpose:
- Realization of a defined feature

Lifetime:
- Short-Lived
  - Created when the developemnt of the feature starts
  - Until the development is **done**

Implications on Coding:
- Allows rebasing (Git)

Benefits:
- Isolation of risk (e.g. unintended side-effects)
- Integration is an explicit decision
- Improves traceability (history)
- By using Continuous Integration the developer might gain valuable feedback from the automatization of tests

Rules:
- Reintegration requires that all designed criteria (e.g. definition of done) are met

#### Topic Branch

Comparison to other Categories:
- Similar to Feature Branch but focussing on finer grained changes than a feature

Lifetime:
- Short-Lived
  - Created when the development of the topic starts
  - Until the development is *done*

Purpose:
- Realization of a non-breaking change, usually an aspect of a defined feature, refactoring etc.

Implications on Coding:
- Small simple changes
- All introduced changes *must* be non-breaking
- Techniques such as e.g. Feature-Toggling are required to shield stakeholders (customers, users, developers, ...) from unintended side-effects
- Allows rebasing (Git)

Benefits:
- Isolation of risk (e.g. unintended side-effects)
- Integration is an explicit decision
- Improves traceability (history)
- Lowering conflict risk in cases where a large number of collaborating units exists
- By using Continuous Integration the developer might gain valuable feedback from the automatization of tests

#### Bugfix Branch

Compared to other Categories:
- Specialized, short-lived derivation of Development Branch

Specialized, short-lived 
- Removal of an undesired side-effect (defect, bug, ...)

#### Release Branches

The notion of a Release Branch might differ, deppending on the context!

##### Prior to Release

In the context of the [Gitflow](#Gitflow) strategy,
Release Branches are used to refine a release candidate prior to it's release.
The release is basically accomplished by reverse integration into *master* and the
application of a label.

##### During Release

The Release Branches is created in order to create a release.
The use of labels for marking a release is discouraged.

Lifetime:
- Long-Lived
  - Created when the release is ready to be locked down
  - Until support of release is discontinued

Rules:
- Lock the branch immediatelly; the only situations that permit a temporary removal of the log
  - Integrating changes for a subsequent minor release
  - In case there is not Hotfix Branch: hotfixing
- Bugs should be fixed in master and subsequently merged to all relevant release branches

Resources:
- [Why not use tags for releases?](https://docs.microsoft.com/en-us/azure/devops/repos/git/git-branching-guidance?view=vsts#why-not-use-tags-for-releases)
- [ALM Basic Branch Plan - Purpose of Release Branch?](https://stackoverflow.com/questions/25293628/alm-basic-branch-plan-purpose-of-release-branch)

#### Servicing Branch

Purpose:
- Provides an additional level of isolation to a Release Branch
- Origin of service pack Release Branches that belong to the same major version
  - A service pack is a collection of bugfixes, hotfixes and features targeting a previous product release

Lifetime:
- Long-Lived
  - Created when the release is ready to be locked down
  - Until support of release is discontinued

Restrictions:
- Never forward integrate from main to servicing, or from servicing to release.

#### Hotfix Branches

Purpose:
- Provides an additional level of isolation to a Release Branch
- Hotfixes can be made in the Hotfix Branch without affecting the history of the Release Branch

Lifetime:
- Long-Lived
  - Created when the release is ready to be locked down
  - Until support of release is discontinued

Restrictions:
- Never forward integrate from servicing to hotfix or from hotfix to release.

Rules:
- Under the presence of a hotfix branch, it is not permitted to apply a hotfix directly to the Release Branch

#### Integration Branch

Compared to other Categories:
- Specialized derivation of Development Branch

Purpose:
- Allows refined control of the integration of multiple branches for some purpose (e.g. creating a release)

#### Test Branch

Purpose:
- Resembles a state of maturity

### Strategies

Criteria:
- Support-Plan
  - Multiple major releases in parallel
    - The intention of releases is to permit the introduction of breaking changes
    - A migration strategy exists
  - A single release is supported
    - Suited for continuous deployment/delivery
- Release-Planning
  - Scheduled
  - Continuous Deployment/Delivery
- Number of collaborating units (teams, ...)
  
Approach:
- Go for the simplest model possible
  - Only branch if neccessary
  - Branches should be be short-lived and thus merged back into *master* as soon as possible, to mitigate long-term merge effects (conflicts, ...)
  - Abundant branches should be deleted since they may be a cause for confusion/overhead
- Evolve as needed

Guidance:
- [Explore how to manage branching strategies with a DevOps mindset in Team Foundation Version Control (TFVC)](https://docs.microsoft.com/en-us/azure/devops/articles/effective-tfvc-branching-strategies-for-devops?view=vsts)
- [Adopt a Git branching strategy](https://docs.microsoft.com/en-us/azure/devops/repos/git/git-branching-guidance?view=vsts)

#### Main Only

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 13
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#main-only)
- [Version Control Walkthrough (Branching Strategies) Part 1 – MAIN Only and Simplicity Rules](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/16/version-control-walkthrough-branching-strategies-part-1-main-only-and-simplicity-rules/)

#### Development Isolation

Relevant Branch Categories:
- Development Branches

Apects:
- Maintains and protects a stable *master*
  - *Master* is e.g. used for releases (assuming the propability of patching is low; might require the introduction of Hot Fix Branches just in case the assumption doesn't hold)
  - Multiple collaborating units may use separate Development Branches
- Long-lived
- Continuously kept in-sync with *master*

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 14
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#development-isolation)
- [Version Control Walkthrough (Branching Strategies) Part 2 – Development Isolation … welcome branching](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/16/version-control-walkthrough-branching-strategies-part-2-development-isolation-welcome-branching/)

#### Feature Isolation

Resources:
- [Git Feature Branch Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows#feature-branch-workflow)
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 18f.
- [Feature Branch Workflow in Git](https://de.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)
- [Version Control Walkthrough (Branching Strategies) Part 3 – Feature Isolation … a special!](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/17/version-control-walkthrough-branching-strategies-part-3-feature-isolation-a-special/)

#### Release Isolation

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 14f.
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#feature-isolation)

#### Development and Release Isolation

Formerly also referred to as *Basic-Branch-Plan*

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 15
- [Parallele Softwareentwicklung spielend meistern](https://www.heise.de/developer/artikel/Parallele-Softwareentwicklung-spielend-meistern-2042425.html?seite=all)

#### Code Promotion

A hierarchie of multiple long-lived branches (e.g. *master* > development > test > release), where each branch represents a higher level of maturity

Disadvantages:
- Due to the disadvantages of long-lived branches, the use of this strategy is usually discouraged

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 18

#### Servicing and Release Isolation

Resources:
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 15f.
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#servicing-and-release-isolation)

#### Servicing, Hotfix and Release Isolation

Resources:- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 17
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#servicing-hotfix-release-isolation)

#### Gitflow

Resources:
- [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Gitflow Workflow](https://de.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

#### Forking

Resources:
- [Forking Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)

#### GitHub Flow

Resources:
- [https://guides.github.com/introduction/flow/](https://guides.github.com/introduction/flow/)

#### VSTS Trunk-Based Development

![branches continuous](./media/branches_cont.svg)

Aspects:
- Code close to master
- Attempt to avoid effects of [Conway's law](https://en.wikipedia.org/wiki/Conway%27s_law)

Resources:
- [The best branching model to work with Git](https://medium.com/@grazibonizi/the-best-branching-model-to-work-with-git-4008a8098e6a)

### Techniques

#### Merging (Universal)

Resources:
- https://backlog.com/git-tutorial/integrating-branches/

##### Reverse integration (Universal)

Merging from child to parent

Purpose:
- Releasing the (assumablly) final state of a change

##### Forward Integration (Universal)

Merging from parent to child

Purpose:
- Regular Forward Integration keeps the deviation from the parent low
  - Multiple small conflic resolutions are less effort in sum than a single large one
- Always Forward Integrate before Reverse Integrate

#### Three-Way-Merge (Universal)

In contrast to a *baseless merge* the latest common node in the history of the version graph
is used to automatically resolve a subset of conflicts.
The amount of situations, where manual intervention is required, is minimized.

Resources:
- [Three-Way Merging: A Look Under the Hood](http://www.drdobbs.com/tools/three-way-merging-a-look-under-the-hood/240164902)

#### Hotfixing (Universal)

Hotfixing refers to the practice that changes are made in or close to the Release Branch, primarily to safe time

Implications:
- Higher risk of undesired side-effects due to the lack of proper testing
- Change need to be integrated in other branches

#### Cherry Picking (Universal)

Selecting only certain files to merge back to main branch. 

#### Feature Toggling (Universal)

Also known as Feature-Flags

Resources:
- [ALM Rangers : Software Development with Feature Toggles](https://msdn.microsoft.com/en-ca/magazine/dn683796.aspx)
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 21

#### Labeling (Universal)

Considerations:
- Lables are mutable

#### Reverting (Universal)

Also known as *Roll-Back**

Each commit is considered a separate unit of change.
This lets you roll back changes if a bug is found, or if you decide to head in a different direction.

#### Fast-Formward-Merge (Git)

Merge that takes advantage that no changes have been comitted sinde branching of

#### Forking/Cloning a remote repository (Git)

- Forks are server-side clones

#### Pushing to a remote repository (Git)

Resources:
- [Pushing to a remote](https://help.github.com/articles/pushing-to-a-remote/)
- [About collaborative development models](https://help.github.com/articles/about-collaborative-development-models/)

#### Syncing with a remote repository (Git)

Resources:
- [Syncing a fork](https://help.github.com/articles/syncing-a-fork/)

#### Pull Requests (Github, Gitlab, Bitbucket, VSTS, ...)

Purpose:
- Information
- Provides an impulse to plan follow-up tasks in the developemnt process (code-review, discussion, ...)

Process:
1. Branch is pushed to a public repository fork, hosted by the provider
2. Pull request is created using the provider's user interface
3. Review process
4. In case all required criteria are met, the branch is fetched into the primary repository and subsequently integrated

Resources:
- [About collaborative development models](https://help.github.com/articles/about-collaborative-development-models/)
- [About pull requests](https://help.github.com/articles/about-pull-requests/)
- [Creating a pull request from a fork](https://help.github.com/articles/creating-a-pull-request-from-a-fork/)
- [Pull Request Tutorial - A Visual Guide to Pull Requests](https://yangsu.github.io/pull-request-tutorial/)

#### Rebasing (Git)

Purpose:
- Edit previous commit messages
- Combine multiple commits into one
- Delete or revert commits that are no longer necessary

Process:
- Invoke `git rebase` for a particular branch
- Use a [set of designated commands](https://help.github.com/articles/about-git-rebase/#commands-available-while-rebasing) to modify the branch-history
- In case that two or more commits modified the same line in the same file, manual conflict resolution is required

Resources:
- [Git Branching - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
- [Using Git rebase on the command line](https://help.github.com/articles/using-git-rebase-on-the-command-line/)

##### Squashing (Git)

Combining multiple commits into a single commit.

Purpose:
- Simplification
- Refinement if individual commits cannot be considered a meaningful unit of change by themselves

#### Reparenting (TFVC)

Resources:
- [TFS – Reparenting a Branch](https://alistairbmackay.wordpress.com/2014/01/15/tfs-reparenting-a-branch/)

### Documenting Change

- Commits also create a transparent history of work
- Each commit has an associated commit message, which is a description explaining *why* a particular change was made

### Versioning

Schemes:
- [Semantic versioning](https://semver.org/)
  - In a continuous deployment scenario, there might be no benefits in using a major version

### Misc

- [Git lost my changes: Taking a look at Git's history simplification](https://docs.microsoft.com/en-us/azure/devops/articles/git-log-history-simplification?view=vsts)

# Deployment

## Strategies

### Decentral

### Central

#### Rolling Deployment

#### A/B Deployment

#### Canary Deployment

#### Highlander Deployment
