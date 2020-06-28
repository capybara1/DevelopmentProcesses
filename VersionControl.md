# Version Control

## Branching

Considerations:

- Using branches increases the risk of merge conflicts which might cause overhead (conflict resolution, testing, ...)
- Using branches decreases the risk of unwanted side-effects by creating isolation

### Categories

#### *Master* (Branch)

Also known as *trunk* or *main(line)*

Common qualities:

- The master branch is always deployable
  - Each commit is thus at least a Potentially Shippable Increment (PSI)
  - In some cases each commit may be even associated with a release version

Resouces:

- https://agilevelocity.com/product-owner/psi-potentially-shippable-increment/
- https://agilevelocity.com/product-owner/the-mmf-minimum-marketable-feature/

#### Development Branch

Comparison to other Categories:

- Long-Lived multi-purpose branch (feature development, bugfixing, integration, ...)

Purpose:

- Maintains and protects the agreed upon qualities of *master*
- Allows collaboration for a small amount of units (teams, ...)

Lifetime:

- Long-Lived
  - Created right after creation fo the repository
  - Indefinite life-span

Rules:

- Integrate in both directions on a regular basis

Disadvantages:

- Does not scale well
- Unless otherwise agreed, anything in the master branch must be always deployable.
  Consequently, commits might become fairly complex, especially if the code base has become complex over time.
  This affects the quality of documentation as described [below](#documenting-change).

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
- Removal of an undesired side-effect (defect, bug, ...)

#### Release Branches

The notion of a Release Branch might differ, deppending on the context!

##### Prior to Release (Integration)

Compared to other Categories:

- A kind of Integration Branch

Purpose:

- Isolates work the _development branch_ from changes which aim
  to complete an upcoming release
  - Allows working on the next version on the _development branch_
- Maintains and protects the agreed upon qualities of *master*
  - Usually in this case each commit to *master* ought to be
    relatable to an actual release version
- Allows collaboration for a small amount of units (teams, ...)

In the context of the [Gitflow](#Gitflow) strategy,
Release Branches are used to refine a release candidate prior to it's release.
The release is basically accomplished by reverse integration into *master* and the
application of a label.

References:

- [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Gitflow Workflow](https://de.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Git Repository Structure](https://github.com/boundlessgeo/suite/wiki/Git-Repository-Structure#release-branches)

##### After Release (Maintenance)

The Release Branches is created in order to create a release.
The use of labels for marking a release is discouraged.

Also known as [Maintenance Branch](https://github.com/boundlessgeo/suite/wiki/Git-Repository-Structure#maintenance-branches)

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

#### Maintenance Branch

See [Release Branches](#release-branches)

References:

- [Git Repository Structure](https://github.com/boundlessgeo/suite/wiki/Git-Repository-Structure#release-branches)

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
- In some cases the notion of a Release Brach is a kind of Integration Branch

Purpose:

- Maintains and protects the agreed upon qualities of *master*
- Allows refined control of the integration of multiple branches for some purpose (e.g. creating a release)

#### Test Branch

Purpose:

- Resembles a state of maturity in the process of promoting changes up a hierarchie

#### Production Branch

Purpose:

- Used in a Continuous Delivery Scenario to manage versioned production releases
  - Merging into the production branch triggers a process that deploys the
    versioned artefacts to the production environment
- Commits only flow downstream
  - Originating from _master_ or a [pre-production branch](#pre-production-branch)

#### Pre-Production Branch

Compared to other Categories:

- Like a [production branch](#production-branch) but without the "Go Life"

Purpose:

- Used in a Continuous Delivery Scenario to manage versioned pre-production releases
  - Merging into the production branch triggers a process that deploys the
    versioned artefacts to the pre-production environment
- Commits only flow downstream
  - Originating from _master_

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
- [Version Control Walkthrough (Branching Strategies) Part 1 � MAIN Only and Simplicity Rules](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/16/version-control-walkthrough-branching-strategies-part-1-main-only-and-simplicity-rules/)

#### Development Isolation

Relevant Branch Categories:

- Development Branches

Aspects:

- Maintains and protects a stable *master*
  - *Master* is e.g. used for releases (assuming the propability of patching is low; might require the introduction of Hot Fix Branches just in case the assumption doesn't hold)
  - Multiple collaborating units may use separate Development Branches
- Long-lived
- Frequently kept in-sync with *master*

Resources:

- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 14
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#development-isolation)
- [Version Control Walkthrough (Branching Strategies) Part 2 � Development Isolation � welcome branching](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/16/version-control-walkthrough-branching-strategies-part-2-development-isolation-welcome-branching/)

#### Feature Isolation

Resources:

- [Git Feature Branch Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows#feature-branch-workflow)
- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 18f.
- [Feature Branch Workflow in Git](https://de.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow)
- [Version Control Walkthrough (Branching Strategies) Part 3 � Feature Isolation � a special!](https://blogs.msdn.microsoft.com/visualstudioalmrangers/2015/09/17/version-control-walkthrough-branching-strategies-part-3-feature-isolation-a-special/)

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

Resources:

- [TFS Version Control V3.1 - Part 1 - Branching Strategies](https://vsardata.blob.core.windows.net/projects/TFS%20Version%20Control%20Part%201%20-%20Branching%20Strategies.pdf), p. 17
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#servicing-hotfix-release-isolation)

#### Gitflow

Resources:

- [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Gitflow Workflow](https://de.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)

#### Git Integration Based Workflow

Resources:

- [Git Integration Based Workflow](http://www.practicalweb.co.uk/blog/2015/02/16/git-integration-branch-based-workflow/)

#### Forking

Resources:

- [Forking Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/forking-workflow)

#### GitHub Flow

Aspects:

- Code close to *master* using Topic Braches
- Designed for Continuous Delivery
- Deployment to production (or a canary server) before the reverse integration of a Topic Branch into *master*

Resources:

- [Understanding the GitHub flow](https://guides.github.com/introduction/flow/)

#### GitLab Flow

Aspects:

- Code close to *master* using Topic Braches
- Designed for Continuous Delivery
  - Promotes the usage of [production](#production-branch) and [pre-production branches](#pre-production-branch)
    - _master_ is deployed on staging
    - _pre-production_ and _production_ branches follow

Resources:

- [Introduction to GitLab Flow](https://docs.gitlab.com/ee/topics/gitlab_flow.html)

#### Trunk-Based Development

![branches continuous](./media/branches_cont.svg)

Aspects:

- Code close to *master* using Topic Braches
- Attempt to avoid effects of [Conway's law](https://en.wikipedia.org/wiki/Conway%27s_law)

Resources:

- [Trunk-Based Development:Introduction](https://trunkbaseddevelopment.com/)
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

##### Three-Way-Merge (Universal)

In contrast to a *baseless merge* the latest common node in the history of the version graph
is used to automatically resolve a subset of conflicts.
The amount of situations, where manual intervention is required, is minimized.

Resources:

- [Three-Way Merging: A Look Under the Hood](http://www.drdobbs.com/tools/three-way-merging-a-look-under-the-hood/240164902)

##### Fast-Formward-Merge (Git)

Merge that takes advantage that no changes have been comitted sinde branching of, targeting a linear history

Resources:

- [Fast-Forward Git Merge](https://ariya.io/2013/09/fast-forward-git-merge)
- [Git Branching - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
- [Git tips: Use only fast-forward merges (with rebase)](https://medium.com/@mvuksano/git-tips-use-only-fast-forward-merges-with-rebase-c80c9d260a83)

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

#### Forking/Cloning a remote repository (Git)

- Forks are server-side clones

#### Pushing to a remote repository (Git)

Resources:

- [Pushing to a remote](https://help.github.com/articles/pushing-to-a-remote/)
- [About collaborative development models](https://help.github.com/articles/about-collaborative-development-models/)

#### Syncing with a remote repository (Git)

Resources:

- [Syncing a fork](https://help.github.com/articles/syncing-a-fork/)

#### Hooks

Resources:

- [Two Ways to Share Git Hooks with Your Team](https://www.viget.com/articles/two-ways-to-share-git-hooks-with-your-team/)
- [Including Hooks in a Git Repository](https://www.darrenlester.com/blog/including-hooks-in-a-git-repository)

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

- Reapply commits on top of another base tip, either unmodified or with modifications
  using a [range of special commands](https://help.github.com/articles/about-git-rebase/#commands-available-while-rebasing)
  provided in the context of rebasing
- One common use-case is to enable a subsequent Fast Forward Merge
  in case the *master* has been modified since the branch was created
- Another common use-case is to clean-up the history of a branch (typically a Feature Branch)
  in order to improve readability and [documentation](#documenting-change)

Disadvantages:

- Do not rebase commits that have already been pushed to a public repository

Resources:

- [rebase documentation](https://git-scm.com/docs/git-rebase)
- [Using Git rebase on the command line](https://help.github.com/articles/using-git-rebase-on-the-command-line/)
- [Git Branching - Rebasing](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)
- [Git Tools - Rewriting History](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)
- [Paul Boxley - Git caret and tilde](http://www.paulboxley.com/blog/2011/06/git-caret-and-tilde)

#### Resetting (Git)

Purpose:

- Changing the position of the HEAD pointer, the staged items and the working directory to a former state

Resources:

- [Git Tools - Reset Demystified](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified)

##### Squashing (Git)

Combining multiple commits into a single commit.

Purpose:

- Simplification
- Refinement if individual commits cannot be considered a meaningful unit of change by themselves

#### Reparenting (TFVC)

Resources:

- [TFS - Reparenting a Branch](https://alistairbmackay.wordpress.com/2014/01/15/tfs-reparenting-a-branch/)

### Documenting Change

- Commits also create a transparent history of work
- Each commit has an associated commit message, which is a description explaining *why* a particular change was made

### Versioning Schemes

#### Semantic Versioning

Purpose:

- Promotes the sole usage of versions to imply compatibility

Implications:

- Version numbers cannot not be influenced by marketing decisions
- Each unit with an isolated build process is versioned individually
  - An additional version for communicating a _product_ that is
    composed of these units is recommended
    - The product versioning scheme ought to be distinguishable
      from the versions of the units in order to prevent confusion e.g.
      by using codenames such as Alpha, Beta, Cupcake, Donut (Android)

Resources:

- [Secification](https://semver.org/)

See also supporting concepts:

- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

## Repositories

### Categories

#### Blessed Repository

A blessed repository is used by every contributor as a reference.
Usually there is only one person who has the rights to push changes to the blessed repository.

Resources:

- [Distributed Git - Distributed Workflows - Centralized Workflow](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows#_centralized_workflow)

#### Monorepo

A single repository for many projects.

Resources:

- [Monorepo - Wikipedia](https://en.wikipedia.org/wiki/Monorepo)

### Strategies

#### Centralized Workflow

One shared repository, open for contributions.

Resources:

- [Distributed Git - Distributed Workflows - Centralized Workflow](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows#_centralized_workflow)

#### Integration Manager Workflow

Forks are created from a blessed repository and used
to pull changes from by a integration manager on request.
Changes which are ready for the integration into the
Blessed Repository are pushed solely by the integration manager.

Resources:

- [Distributed Git - Distributed Workflows - Integration-Manager Workflow](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows#_integration_manager)

#### Dictator and Lieutenants Workflow

Similar to the Integration Manager Workflow, yet uses
an additional layer of secondary integration managers (Lieutenants)
that request pulls from the primary integration manager (Dictator).

Resources:

- [Distributed Git - Distributed Workflows - Centralized Workflow](https://git-scm.com/book/en/v2/Distributed-Git-Distributed-Workflows#_dictator_and_lieutenants_workflow)
