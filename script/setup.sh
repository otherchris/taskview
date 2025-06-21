#!/bin/bash

# Install Playwright CLI
PLAYWRIGHT_CLI_VERSION=$(bundle exec ruby -e 'require "playwright"; puts Playwright::COMPATIBLE_PLAYWRIGHT_VERSION.strip')
npm install -D "playwright@$PLAYWRIGHT_CLI_VERSION"
npx playwright install

# Install Playwright Ruby
bundle add playwright-ruby-client