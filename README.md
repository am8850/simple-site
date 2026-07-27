# simple-site

Simple Astro **personal blog** focused on **agentic development and AI news**, ready for deployment to **Azure Static Web Apps** behind **Azure Front Door Standard with WAF**.

## What is included

- **Astro** personal blog website
- **Tailwind CSS** styling
- **Bicep** templates in `infrastructure/` to provision an Azure Static Web App behind Azure Front Door Standard with WAF
- **GitHub Actions** workflows for CI and deployment
- **Dependabot** configuration for npm and GitHub Actions updates

## Local development

### Prerequisites

- Node.js 22 or later
- npm

### Install dependencies

```bash
npm install
```

### Start the local development server

```bash
npm run dev
```

### Build the site

```bash
npm run build
```

### Validate Astro files

```bash
npm run check
```

### Preview the production build

```bash
npm run preview
```

## Infrastructure

The Bicep files live in the `infrastructure/` folder.

- `infrastructure/main.bicep` provisions the Azure Static Web App, Azure Front Door Standard, and a basic WAF policy
- `infrastructure/main.bicepparam` contains example parameter values for the Static Web App, Front Door, and WAF

The default deployment topology is:

- **Azure Static Web App** as the origin host
- **Azure Front Door Standard** as the public entry point
- **Front Door WAF** in **Prevention** mode using a basic Microsoft-managed rule set
- **Default Front Door hostname** (`*.azurefd.net`) for public access

### Deploy the infrastructure with Azure CLI

Create a resource group if needed:

```bash
az group create --name rg-simple-site --location eastus2
```

Deploy the Bicep template:

```bash
az deployment group create \
  --resource-group rg-simple-site \
  --template-file infrastructure/main.bicep \
  --parameters infrastructure/main.bicepparam
```

Useful outputs after deployment include:

- `defaultHostname` - the Azure Static Web App hostname
- `frontDoorEndpointHostname` - the public Azure Front Door hostname
- `frontDoorProfileNameOutput` - the Azure Front Door profile name
- `frontDoorWafPolicyNameOutput` - the WAF policy name

## GitHub Actions

This repo includes:

- `.github/workflows/ci.yml` for install, validation, and build
- `.github/workflows/deploy.yml` for infrastructure deployment and Static Web App content deployment

## Blog structure

- `src/pages/index.astro` contains the personal blog landing page
- `src/pages/blog/index.astro` contains the blog archive page
- `src/pages/blog/[slug].astro` renders individual static blog posts
- `src/data/posts.ts` contains sample posts about agentic development and AI news you can replace later

## Required GitHub secret

To enable the deployment workflow, add this repository secret:

- `AZURE_STATIC_WEB_APPS_API_TOKEN`

You can retrieve the deployment token for your Static Web App from the Azure Portal or with Azure CLI after the resource has been created.

The workflow still deploys the site content directly to the Static Web App. Azure Front Door and WAF sit in front of the app and do not change the Static Web App deployment token flow.

## Dependabot

Dependabot is configured in `.github/dependabot.yml` to keep npm dependencies and GitHub Actions versions up to date.
