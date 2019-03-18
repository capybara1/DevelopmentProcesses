# Dependency Management

## Challenges

- Conflicting versions due to transitive dependencies
- Repeatability of builds
  - Usually realized by lock-files

## Strategies

### Monorepo

Categories:
- Project based
- Containing all code of a company

- Ups:
  - With individual repositories per package, the publication of
    a package is required before it can be used. In a monorepo
    this step can be omitted
  - Ease of using dependent packages within the same repository
    encourages to improve the reusability of code
  - Simplifies large refactorings
- Downs:
  - Requires specialized tools and workflows, for example:
    - [Lerna](https://lernajs.io/)
    - [Yarn](https://yarnpkg.com)
  - Higher risk of violating the *separation of concerns*
    in a reasonable large code-base due to missing isolation
  - Size, Scalability

Resources:
- [Building large scale react applications in a monorepo](https://medium.com/@luisvieira_gmr/building-large-scale-react-applications-in-a-monorepo-91cd4637c131)
- [Monorepos in the Wild](https://medium.com/@maoberlehner/monorepos-in-the-wild-33c6eb246cb9)
- [Monorepos: Please don’t!](https://medium.com/@mattklein123/monorepos-please-dont-e9a279be011b)
- [Sharing UI Components with Lerna and Yarn Workspaces](https://medium.com/naresh-bhatia/sharing-ui-components-with-lerna-and-yarn-workspaces-be1ebca06efe)

### Packages

#### Package Size

##### Micro-Packages

- Ups
  - Less excess of code for unsused functionality per package
- Downs
  - Requires tools to remain maintainable
  - License Management becomes harder
  - Reduces performance

- [The Era Of Micro Packages](https://developer.telerik.com/content-types/opinion/era-micro-packages/)
- [NPM & left-pad: Have We Forgotten How To Program?](https://www.davidhaney.io/npm-left-pad-have-we-forgotten-how-to-program/)

#### Package Management

- [NPM](https://www.npmjs.com/)
- [NuGet](https://www.nuget.org/)
- [Yarn](https://yarnpkg.com)

Resources:
- [Yarn vs npm - which Node package manager to use in 2018?](https://blog.risingstack.com/yarn-vs-npm-node-js-package-managers/)

### Submodules (Git)

### Web Services

#### Microservices

> In short, the microservice architectural style is an approach
> to developing a single application as a suite of small services,
> each running in its own process and communicating with lightweight mechanisms,
> often an HTTP resource API. These services are built around business capabilities
> and independently deployable by fully automated deployment machinery.
> There is a bare minimum of centralized management of these services,
> which may be written in different programming languages and use different data storage technologies.

Recommended:
- Elastic Load Balance (ELB)
  - Automated operations
  - On demand provisioning

- [Microservices - a definition of this new architectural term](https://martinfowler.com/articles/microservices.html)
- [Mastering Chaos - A Netflix Guide to Microservices](https://www.youtube.com/watch?v=CZ3wIuvmHeM)

## License Management
