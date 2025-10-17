# Documentation Infrastructure Standards

Best practices for building scalable, maintainable documentation systems with automation and testing.

## Static Site Generator Selection

### Decision Matrix

| Generator | Best For | Pros | Cons |
|-----------|----------|------|------|
| **Docusaurus** | Modern docs with React | Feature-rich, great DX, versioning | React dependency |
| **MkDocs** | Python projects, simplicity | Simple, fast, Markdown-first | Limited customization |
| **VitePress** | Vue projects, performance | Very fast, clean design | Vue dependency |
| **Nextra** | Next.js integration | Flexible, SSG/SSR | Next.js learning curve |
| **Sphinx** | Python API docs, technical | Powerful, extensible | Steeper learning curve |

### Docusaurus Setup (Recommended)
```bash
# Initialize new docs site
npx create-docusaurus@latest my-docs classic --typescript

# Project structure
my-docs/
├── docs/                    # Documentation pages
│   ├── intro.md
│   ├── getting-started/
│   └── api/
├── blog/                    # Blog posts (optional)
├── src/
│   ├── components/          # Custom React components
│   ├── css/                 # Custom styles
│   └── pages/               # Custom pages
├── static/                  # Static assets
│   ├── img/
│   └── files/
├── docusaurus.config.js     # Main configuration
├── sidebars.js              # Sidebar configuration
└── package.json
```

### Configuration Best Practices
```javascript
// docusaurus.config.js
module.exports = {
  title: 'My Documentation',
  tagline: 'Clear, concise API documentation',
  url: 'https://docs.example.com',
  baseUrl: '/',
  
  // Performance
  onBrokenLinks: 'throw',          // Fail build on broken links
  onBrokenMarkdownLinks: 'throw',  // Fail on broken MD links
  
  // SEO
  headTags: [
    {
      tagName: 'link',
      attributes: {
        rel: 'canonical',
        href: 'https://docs.example.com',
      },
    },
  ],
  
  // Internationalization
  i18n: {
    defaultLocale: 'en',
    locales: ['en', 'es', 'fr'],
  },
  
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          editUrl: 'https://github.com/org/docs/edit/main/',
          showLastUpdateTime: true,
          showLastUpdateAuthor: true,
          
          // Versioning
          versions: {
            current: {
              label: '2.0 (Next)',
              banner: 'unreleased',
            },
          },
        },
        
        blog: {
          showReadingTime: true,
          feedOptions: {
            type: 'all',
          },
        },
        
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
        
        // Analytics
        googleAnalytics: {
          trackingID: 'UA-XXXXXXXXX-X',
        },
      },
    ],
  ],
  
  themeConfig: {
    // Navbar
    navbar: {
      title: 'Docs',
      logo: {
        alt: 'Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'Documentation',
        },
        {
          type: 'docsVersionDropdown',
          position: 'right',
        },
        {
          href: 'https://github.com/org/repo',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    
    // Footer
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Docs',
          items: [
            { label: 'Getting Started', to: '/docs/intro' },
            { label: 'API Reference', to: '/docs/api' },
          ],
        },
        {
          title: 'Community',
          items: [
            { label: 'Discord', href: 'https://discord.gg/...' },
            { label: 'Twitter', href: 'https://twitter.com/...' },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} My Company.`,
    },
    
    // Search (Algolia DocSearch)
    algolia: {
      appId: 'YOUR_APP_ID',
      apiKey: 'YOUR_SEARCH_API_KEY',
      indexName: 'docs',
      contextualSearch: true,
      searchPagePath: 'search',
    },
    
    // Code highlighting
    prism: {
      theme: require('prism-react-renderer/themes/github'),
      darkTheme: require('prism-react-renderer/themes/dracula'),
      additionalLanguages: ['ruby', 'go', 'rust', 'php'],
    },
  },
};
```

## CI/CD Pipeline

### GitHub Actions Workflow
```yaml
# .github/workflows/docs.yml
name: Documentation CI/CD

on:
  push:
    branches: [main]
    paths:
      - 'docs/**'
      - 'src/**'
      - 'docusaurus.config.js'
  pull_request:
    paths:
      - 'docs/**'

jobs:
  # Quality checks
  checks:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Spell check
        uses: streetsidesoftware/cspell-action@v2
        with:
          files: 'docs/**/*.md'
          config: '.cspell.json'
      
      - name: Markdown lint
        run: npx markdownlint 'docs/**/*.md'
      
      - name: Check links
        run: npm run check:links
      
      - name: Test code examples
        run: npm run test:examples
      
      - name: Build documentation
        run: npm run build
      
      - name: Validate OpenAPI spec
        if: hashFiles('docs/api/openapi.yaml')
        run: |
          npx @redocly/cli lint docs/api/openapi.yaml

  # Deploy preview for PRs
  deploy-preview:
    if: github.event_name == 'pull_request'
    runs-on: ubuntu-latest
    needs: checks
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install and build
        run: |
          npm ci
          npm run build
      
      - name: Deploy to Netlify
        uses: netlify/actions/cli@master
        with:
          args: deploy --dir=build --alias=pr-${{ github.event.number }}
        env:
          NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
          NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
      
      - name: Comment PR
        uses: actions/github-script@v6
        with:
          script: |
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: `📝 Documentation preview: https://pr-${context.issue.number}--docs.netlify.app`
            })

  # Deploy to production
  deploy-production:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    needs: checks
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          cache: 'npm'
      
      - name: Install and build
        run: |
          npm ci
          npm run build
      
      - name: Deploy to production
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build
          cname: docs.example.com
      
      - name: Notify deployment
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Documentation deployed to production'
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

## Testing Framework

### Link Checking
```javascript
// scripts/check-links.js
const glob = require('glob');
const fs = require('fs');
const matter = require('gray-matter');

async function checkLinks() {
  const files = glob.sync('docs/**/*.md');
  const allLinks = new Set();
  const brokenLinks = [];
  
  // Extract all internal links
  for (const file of files) {
    const content = fs.readFileSync(file, 'utf8');
    const { data, content: markdown } = matter(content);
    
    // Match markdown links [text](url)
    const linkRegex = /\[([^\]]+)\]\(([^)]+)\)/g;
    let match;
    
    while ((match = linkRegex.exec(markdown)) !== null) {
      const [, text, url] = match;
      
      // Check internal links
      if (!url.startsWith('http')) {
        allLinks.add({ file, text, url });
      }
    }
  }
  
  // Verify each link exists
  for (const { file, text, url } of allLinks) {
    const targetPath = resolveLink(file, url);
    if (!fs.existsSync(targetPath)) {
      brokenLinks.push({ file, text, url });
    }
  }
  
  if (brokenLinks.length > 0) {
    console.error('❌ Broken links found:');
    brokenLinks.forEach(({ file, text, url }) => {
      console.error(`  ${file}: [${text}](${url})`);
    });
    process.exit(1);
  }
  
  console.log('✅ All links valid');
}

checkLinks();
```

### Code Example Testing
```javascript
// scripts/test-examples.js
const glob = require('glob');
const fs = require('fs');
const { exec } = require('child_process');
const util = require('util');

const execAsync = util.promisify(exec);

async function testCodeExamples() {
  const files = glob.sync('docs/**/*.md');
  const results = [];
  
  for (const file of files) {
    const content = fs.readFileSync(file, 'utf8');
    
    // Extract code blocks with language
    const codeBlockRegex = /```(\w+)\n([\s\S]+?)```/g;
    let match;
    let blockIndex = 0;
    
    while ((match = codeBlockRegex.exec(content)) !== null) {
      const [, lang, code] = match;
      blockIndex++;
      
      // Skip non-executable languages
      if (['json', 'yaml', 'markdown', 'text'].includes(lang)) {
        continue;
      }
      
      console.log(`Testing ${file}:${blockIndex} (${lang})`);
      
      try {
        await testCodeBlock(lang, code, file, blockIndex);
        results.push({ file, block: blockIndex, status: 'pass' });
      } catch (error) {
        results.push({ 
          file, 
          block: blockIndex, 
          status: 'fail', 
          error: error.message 
        });
      }
    }
  }
  
  // Print results
  const failed = results.filter(r => r.status === 'fail');
  
  if (failed.length > 0) {
    console.error('\n❌ Failed code examples:');
    failed.forEach(({ file, block, error }) => {
      console.error(`  ${file}:block-${block}: ${error}`);
    });
    process.exit(1);
  }
  
  console.log(`\n✅ All code examples passed (${results.length} tested)`);
}

async function testCodeBlock(lang, code, file, block) {
  // Write code to temp file
  const tempFile = `/tmp/test-${Date.now()}.${getExtension(lang)}`;
  fs.writeFileSync(tempFile, code);
  
  try {
    switch (lang) {
      case 'javascript':
      case 'js':
        await execAsync(`node ${tempFile}`);
        break;
      case 'typescript':
      case 'ts':
        await execAsync(`npx ts-node ${tempFile}`);
        break;
      case 'python':
        await execAsync(`python3 ${tempFile}`);
        break;
      case 'bash':
      case 'shell':
        await execAsync(`bash ${tempFile}`);
        break;
      default:
        // Skip unknown languages
        break;
    }
  } finally {
    fs.unlinkSync(tempFile);
  }
}

testCodeExamples();
```

### Accessibility Testing
```javascript
// scripts/check-accessibility.js
const glob = require('glob');
const fs = require('fs');
const matter = require('gray-matter');

function checkAccessibility() {
  const files = glob.sync('docs/**/*.md');
  const issues = [];
  
  for (const file of files) {
    const content = fs.readFileSync(file, 'utf8');
    const { content: markdown } = matter(content);
    
    // Check for images without alt text
    const imgRegex = /!\[\s*\]\([^)]+\)/g;
    const noAltMatches = markdown.match(imgRegex);
    if (noAltMatches) {
      issues.push({
        file,
        type: 'missing-alt-text',
        count: noAltMatches.length,
        example: noAltMatches[0]
      });
    }
    
    // Check for "click here" links
    const clickHereRegex = /\[(click here|here)\]\([^)]+\)/gi;
    const clickHereMatches = markdown.match(clickHereRegex);
    if (clickHereMatches) {
      issues.push({
        file,
        type: 'non-descriptive-link',
        count: clickHereMatches.length,
        example: clickHereMatches[0]
      });
    }
  }
  
  if (issues.length > 0) {
    console.error('⚠️  Accessibility issues found:');
    issues.forEach(({ file, type, count, example }) => {
      console.error(`  ${file}: ${count}x ${type}`);
      console.error(`    Example: ${example}`);
    });
    process.exit(1);
  }
  
  console.log('✅ All accessibility checks passed');
}

checkAccessibility();
```

## Search Configuration

### Algolia DocSearch Setup
```javascript
// docusaurus.config.js
module.exports = {
  themeConfig: {
    algolia: {
      appId: 'YOUR_APP_ID',
      apiKey: 'YOUR_SEARCH_API_KEY',
      indexName: 'docs',
      
      // Contextual search (filter by version)
      contextualSearch: true,
      
      // Search page
      searchPagePath: 'search',
      
      // Search parameters
      searchParameters: {
        facetFilters: ['language:en', 'version:current'],
        hitsPerPage: 10,
      },
    },
  },
};
```

### Algolia Crawler Configuration
```json
{
  "index_name": "docs",
  "start_urls": [
    {
      "url": "https://docs.example.com/",
      "selectors_key": "default",
      "tags": ["latest"]
    }
  ],
  "selectors": {
    "default": {
      "lvl0": {
        "selector": ".theme-doc-sidebar-item-category-level-1 > a",
        "global": true,
        "default_value": "Documentation"
      },
      "lvl1": "article h1",
      "lvl2": "article h2",
      "lvl3": "article h3",
      "lvl4": "article h4",
      "text": "article p, article li"
    }
  },
  "sitemap_urls": [
    "https://docs.example.com/sitemap.xml"
  ],
  "stop_urls": [
    "https://docs.example.com/search"
  ]
}
```

## Performance Optimization

### Build Performance
```javascript
// package.json scripts
{
  "scripts": {
    "start": "docusaurus start",
    "build": "docusaurus build",
    "build:fast": "DOCUSAURUS_CURRENT_LOCALE=en docusaurus build",
    "serve": "docusaurus serve",
    "clear": "docusaurus clear",
    
    // Pre-build optimizations
    "optimize:images": "npx @docusaurus/plugin-image-loader",
    "optimize:search": "docusaurus build && docusaurus-to-algolia"
  }
}
```

### Image Optimization
```javascript
// docusaurus.config.js
module.exports = {
  plugins: [
    [
      '@docusaurus/plugin-ideal-image',
      {
        quality: 70,
        max: 1030,
        min: 640,
        steps: 2,
        disableInDev: false,
      },
    ],
  ],
};
```

## Monitoring and Analytics

### Health Dashboard
```javascript
// scripts/health-check.js
const metrics = {
  buildTime: measureBuildTime(),
  brokenLinks: countBrokenLinks(),
  codeExamplesFailing: countFailingExamples(),
  searchCoverage: calculateSearchCoverage(),
  avgPageLoad: measureAvgPageLoad(),
  pageViews30d: getPageViews(),
  searchSuccessRate: getSearchSuccessRate(),
};

console.log('📊 Documentation Health Report');
console.log('================================');
console.log(`Build Time: ${metrics.buildTime}s (target: <60s)`);
console.log(`Broken Links: ${metrics.brokenLinks} (target: 0)`);
console.log(`Failing Examples: ${metrics.codeExamplesFailing} (target: 0)`);
console.log(`Search Coverage: ${metrics.searchCoverage}% (target: >95%)`);
console.log(`Avg Page Load: ${metrics.avgPageLoad}ms (target: <2000ms)`);
console.log(`Page Views (30d): ${metrics.pageViews30d.toLocaleString()}`);
console.log(`Search Success: ${metrics.searchSuccessRate}% (target: >90%)`);
```

Always prioritize automation, testing, and maintainability in documentation infrastructure.
