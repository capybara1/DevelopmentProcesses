# Version Control

## Branching

Considerations:
- Using branches increases the risk of merge conflicts which might cause overhead (conflict resolution, testing, ...)
- Using branches decreases the risk of unwanted side-effects by creating isolation

### Categories

#### *Master* (Branch)

- Also known as *trunk* or *main(line)*
- Usually the *master* provides the latest changes which are considered *stable*

#### Development Branch

Purpose:
- Maintains and protects a stable *master*

Lifetime:
- Long-Lived
  - Created right after creation fo the repository
  - Indefinite life-span

#### Feature Branches

Specialized derivation of Development Branch (short-lived)
Reintegration requires that all designed criteria (e.g. definition of done) are met

Purpose:
- Realization of a defined feature

Implications on Coding:
- Allows rebasing (Git)

Benefits:
- Isolation of risk (e.g. unintended side-effects)
- Integration is an explicit decision
- Improves traceability (history)
- By using Continuous Integration the developer might gain valuable feedback from the automatization of tests

#### Topic Branch

Purpose:
- Realization of a non-breaking change, usually an aspect of a defined feature, refactoring etc.

Implications on Coding:
- Small simple changes
- All introduced changes *must* be non-breaking
- Means such as e.g. Feature-Flags are required to shield stakeholders (customers, users, developers, ...) from unintended side-effects
- Allows rebasing (Git)

Benefits:
- Isolation of risk (e.g. unintended side-effects)
- Integration is an explicit decision
- Improves traceability (history)
- Lowering conflict risk in cases where a large number of collaborating units exists
- By using Continuous Integration the developer might gain valuable feedback from the automatization of tests

#### Bugfix Branch

Specialized derivation of Feature Branch which does target the introduction of a new feature but the amendment of an undesired side-effect (bug)

#### Release Branches

Lifetime:
- Long-Lived
  - Created when the release is ready to be locked down
  - Until support of release is discontinued


Handling of Bugs:
- Should be fixed in master and subsequently merged to all relevant release branches

#### Servicing Branch

Purpose:
- Provides an additional level of isolation to a Release Branch
- Origin of service pack Release Branches that belong to the same major version

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

#### Integration Branch

Purpose:
- Allows  refined control of the integration of multiple branches for some purpose (e.g. creating a release)

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
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#main-only)

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
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#development-isolation)

#### Feature Isolation

https://de.atlassian.com/git/tutorials/comparing-workflows/feature-branch-workflow

#### Release Isolation

Resources:

- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#feature-isolation)

#### Servicing and Release Isolation

Resources:
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#servicing-and-release-isolation)

#### Servicing, Hotfix and Release Isolation

Resources:
- [TFVC Guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/tfvc/branching-strategies-with-tfvc?view=vsts#servicing-hotfix-release-isolation)

#### Git-Flow

Aspects:
- Code close to master

Resources:
- [Git-flow-Workflow](https://de.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [The best branching model to work with Git](https://medium.com/@grazibonizi/the-best-branching-model-to-work-with-git-4008a8098e6a)

### Techniques

#### Three-Way-Merge (Universal)

TODO: Implictions of direction?

#### Hotfixing (Universal)

Hotfixing refers to the practice that changes are made in or close to the Release Branch, primarily to safe time

Implications:
- Higher risk of undesired side-effects due to the lack of proper testing
- Change need to be integrated in other branches

#### Fast-Formward-Merge (Git)

#### Squashing (Git)

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
- https://help.github.com/articles/about-pull-requests/
- https://yangsu.github.io/pull-request-tutorial/
- https://help.github.com/articles/creating-a-pull-request-from-a-fork/

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
