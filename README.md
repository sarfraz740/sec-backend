# Share-e-care backend

<p>
  <a href="https://www.serverless.com">
    <img src="http://public.serverless.com/badges/v3.svg">
  </a>
  <a href="https://www.npmjs.com/package/serverless-offline">
    <img src="https://img.shields.io/npm/v/serverless-offline.svg?style=flat-square">
  </a>
  <a href="https://github.com/dherault/serverless-offline/actions/workflows/integrate.yml">
    <img src="https://img.shields.io/github/workflow/status/dherault/serverless-offline/Integrate">
  </a>
  <img src="https://img.shields.io/node/v/serverless-offline.svg?style=flat-square">
  <a href="https://github.com/serverless/serverless">
    <img src="https://img.shields.io/npm/dependency-version/serverless-offline/peer/serverless.svg?style=flat-square">
  </a>
  <a href="https://github.com/prettier/prettier">
    <img src="https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square">
  </a>
</p>

## Versions

```sh
node - v16.17.0
npm - 8.15.0
mysql - 8.0.32
serverless - Framework Core: 3.22.0
             Plugin: 6.2.2
             SDK: 4.3.2
```

## Documentation

-   [Installation](#installation)
-   [Usage and command line options](#usage-and-command-line-options)
-   [Running Test Cases](#running-test-cases)

## Installation

```sh
npm install
## or
yarn
```

This runs the serverless function locally using `serverless-offline` plugin.

## Usage and command line options

```
yarn dev
```
#sarfraz
## Microservices

Each microservice is separated in the folders and it has separate functions serverless.yml file. Please use respective folder and do the changes accordingly

## Before comminting the changes to git

1. run `sh yarn prettify`
2. run `sh yarn format`

### NOTE: For git

For modifiying and pushing your changes to git follow the steps

1. Create and checkout to a new branch `sh git branch <your-name>/<feature-name>` (create this if not created a new branch)
2. Checkout to new branch `sh git checkout <your-name>/<feature-name>`
3. Do the changes to your files
4. Now add the changes to repo `sh git add <files>`
5. Then commit your changes (commit should be in the following format)
   a. For adding new features `sh git commit -m "feat: Your message about the commit"`
   b. For bug fixing `sh git commit -m "fix: Your message about the commit"`
6. At last push your changes to git `sh git push <your-name>/<feature-name>`. Do not push to any other branch.
7. Once you push your changes go to github and create a pull request from '<your-name>/<feature-name>' to 'develop'. Do not create a pull request to any other branch
