export PLAYWRIGHT_CLI_VERSION=$(bundle exec ruby -e 'require "playwright"; puts Playwright::COMPATIBLE_PLAYWRIGHT_VERSION.strip')
npm add -D "playwright@$PLAYWRIGHT_CLI_VERSION"
npm run playwright:install