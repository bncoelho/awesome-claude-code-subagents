# Design Review Standards

World-class UI/UX review standards inspired by Stripe, Airbnb, and Linear.

## Design Review Philosophy

**Live Environment First**: Test interactive user experience BEFORE analyzing code.

## Visual Design Standards

### Layout & Spacing
- Consistent spacing system (8px, 16px, 24px, 32px, etc.)
- Adequate whitespace (not cramped, not sparse)
- Grid alignment (elements aligned to grid)
- Responsive layout adapts gracefully
- No unexpected horizontal scrolling

### Typography
- Clear heading hierarchy (visual size and weight distinction)
- Readable font sizes (minimum 16px for body text on desktop)
- Appropriate line height (1.5-1.6 for readability)
- Contrast sufficient for readability
- Font choices consistent and limited (2-3 font families maximum)

### Color & Visual Hierarchy
- Color palette consistent throughout
- Adequate contrast (text on background, UI elements)
- Color not sole method of conveying information
- Visual hierarchy guides user attention
- Consistent use of colors for similar elements

### Components
- Visual consistency across similar components
- States clearly distinguished (hover, active, disabled, focus)
- Icons consistent in style and weight
- Images high quality and properly optimized
- Loading states clearly communicated

## User Experience Standards

### Interaction & Responsiveness
- Interactive elements respond immediately (perceived performance)
- Hover states provide clear feedback
- Click targets adequate size (44x44px minimum)
- Touch targets properly spaced
- No unexpected behavior or side effects

### User Flow
- Primary user flow is intuitive and obvious
- Minimal clicks to accomplish task
- Clear call-to-action elements
- Logical progression through interface
- No confusing or hidden features

### Feedback & Communication
- Destructive actions require confirmation
- Success/error states clearly communicated
- Loading states visible
- Empty states handled gracefully
- Error messages helpful and specific

## Accessibility Standards

### Keyboard Navigation
- Tab order logical and predictable
- Focus indicators visible and clear
- All functionality available via keyboard
- No keyboard traps
- Escape dismisses overlays

### Screen Reader Compatibility
- Semantic HTML elements (nav, main, article, etc.)
- Form labels properly associated
- Image alt text descriptive and meaningful
- Heading structure logical
- ARIA attributes used correctly

### Visual Accessibility
- Text-to-background 4.5:1 contrast minimum
- Large text 3:1 contrast minimum
- Color not sole information method
- Text resizable to 200% without loss
- No auto-playing audio

## Responsive Design

### Desktop (1440px)
- Full layout with all features visible
- Optimal spacing and readability
- Efficient use of space

### Tablet (768px)
- Layout adapts to narrower viewport
- Touch targets still adequate
- Navigation transforms appropriately
- No horizontal scrolling

### Mobile (375px)
- Single column or stacked layout
- Touch-friendly spacing (44x44px minimum)
- Navigation becomes menu/drawer
- Content scannable and concise
- Viewport properly configured

## Content Standards

### Copy
- Clear, concise language
- Active voice preferred
- Consistent terminology
- Proper grammar and spelling
- Jargon explained or avoided

### Microcopy
- Helpful button labels (action-oriented)
- Clear form labels and placeholders
- Error messages specific and actionable
- Help text clear and concise

## Code Health

### Component Architecture
- Components reused appropriately
- Duplication minimized
- Component interfaces clear
- Props well-documented

### Styling
- Design tokens used consistently (no magic numbers)
- CSS organized and maintainable
- BEM or similar naming convention
- Vendor prefixes where needed
- CSS follows established patterns

### Performance
- Images optimized
- CSS/JS not blocking rendering
- Animations smooth (60fps)
- Bundle size reasonable

## Common Design Issues (Anti-patterns)

**DO NOT:**
- Use color alone to convey information
- Have invisible or hard-to-see focus indicators
- Create inconsistent spacing or alignment
- Use placeholder text as form label
- Have auto-playing audio or video
- Disable zoom functionality
- Use images of text
- Hide navigation on desktop
- Create keyboard traps
- Have unreadable color contrast

**DO:**
- Provide visual feedback on interactions
- Maintain consistent design patterns
- Ensure adequate spacing and alignment
- Use semantic HTML
- Test on multiple devices/viewports
- Provide keyboard alternatives
- Optimize images for web
- Keep interface simple and focused
- Follow established design system
- Test with real users when possible

## Design Review Triage

### Blocker Issues
- Broken functionality
- Severe accessibility violation (keyboard trap, invisible focus)
- Major usability problem
- Data loss or security issue

### High-Priority
- Significant visual inconsistency
- Poor color contrast (fails WCAG)
- Confusing interaction pattern
- Major responsive design issue

### Medium-Priority
- Minor visual inconsistency
- Optimizable user flow
- Potential accessibility concern
- Minor performance issue

### Nitpick
- Minor aesthetic detail
- Optional polish
- Non-critical spacing adjustment
- Stylistic suggestion
