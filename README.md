# simple-site

Simple Astro **personal blog** focused on **agentic development and AI news**, ready for deployment to **Azure Static Web Apps**.

## What is included

- **Astro** personal blog website
- **Tailwind CSS** styling
- **Bicep** templates in `infrastructure/` to provision an Azure Static Web App
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

- `infrastructure/main.bicep` provisions the Azure Static Web App
- `infrastructure/main.bicepparam` contains example parameter values

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

## GitHub Actions

This repo includes:

- `.github/workflows/ci.yml` for install, validation, and build
- `.github/workflows/deploy.yml` for deployment to Azure Static Web Apps

## Blog structure

- `src/pages/index.astro` contains the personal blog landing page
- `src/pages/blog/index.astro` contains the blog archive page
- `src/pages/blog/[slug].astro` renders individual static blog posts
- `src/data/posts.ts` contains sample posts about agentic development and AI news you can replace later

## Required GitHub secret

To enable the deployment workflow, add this repository secret:

- `AZURE_STATIC_WEB_APPS_API_TOKEN`

You can retrieve the deployment token for your Static Web App from the Azure Portal or with Azure CLI after the resource has been created.

## Dependabot

Dependabot is configured in `.github/dependabot.yml` to keep npm dependencies and GitHub Actions versions up to date.
