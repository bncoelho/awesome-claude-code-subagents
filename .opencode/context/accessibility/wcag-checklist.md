# WCAG 2.1 AA Accessibility Checklist

World-class accessibility standards for design reviews.

## Perception (Discernible)

### 1.1 Text Alternatives
- All images have descriptive alt text
- Decorative images have empty alt attributes (alt="")
- Alt text describes purpose, not "image of" or "picture of"
- Complex images have detailed descriptions

### 1.2 Time-Based Media
- Videos have captions
- Audio has transcripts
- Audio descriptions for visual content

### 1.3 Adaptable
- Content is structured logically with proper heading hierarchy (H1 → H6)
- Reading order matches visual order
- Instructions don't rely solely on shape, size, or visual location
- Color alone doesn't convey information (supplemented with text/pattern)

### 1.4 Distinguishable
- Text has minimum 4.5:1 contrast ratio for normal text
- Text has minimum 3:1 contrast ratio for large text (18pt+)
- Text can be resized up to 200% without loss of functionality
- No images of text (except logos/branding)
- No auto-playing audio longer than 3 seconds

## Operation (Operable)

### 2.1 Keyboard Accessible
- All functionality available via keyboard
- Tab order is logical and follows visual order
- No keyboard traps (can tab away from all elements)
- No reliance on mouse-only interactions
- Focus indicator is visible and clear

### 2.2 Enough Time
- No time limits on content
- Or user can extend, disable, or adjust time limits
- No auto-refreshing or auto-redirecting content
- No blinking or flashing (frequency 3-39 Hz)

### 2.3 Seizures and Physical Reactions
- No content flashing more than 3 times per second
- Moving content can be paused/stopped

### 2.4 Navigable
- Purpose of each link is clear from link text or context
- Multiple ways to find pages (navigation, search, site map)
- Headings and labels describe topic or purpose
- Focus visible on all interactive elements
- Page title describes topic or purpose

### 2.5 Input Modalities
- Touch targets minimum 44x44 pixels
- Gestures don't require specific path or timing
- Labels visible and associated with inputs
- Instructions don't require specific finger movements

## Understandable (Intelligible)

### 3.1 Readable
- Page language specified
- Abbreviations/acronyms defined on first use or in glossary
- Pronunciation provided for words with unclear pronunciation
- Content written clearly and simply

### 3.2 Predictable
- Navigation is consistent across pages
- Components behave predictably
- Changes don't occur unexpectedly
- Forms don't submit automatically
- Inputs provide clear labels

### 3.3 Input Assistance
- Form fields have descriptive labels (associated with input)
- Instructions provided for complex forms
- Errors identified (text and visually)
- Error messages suggest corrections
- Review and confirmation for important data

## Robust (Compatible)

### 4.1 Compatible
- Valid HTML markup (proper nesting, no duplicate IDs)
- Proper semantic HTML elements (nav, main, header, footer, article, etc.)
- ARIA attributes used correctly when semantic HTML insufficient
- Focus management proper for dynamic content
- Name, role, value exposed to accessibility API

## Design Review Validation Steps

### Step 1: Keyboard Navigation
- [ ] Tab through entire interface
- [ ] Tab order is logical (left to right, top to bottom)
- [ ] Shift+Tab cycles backward
- [ ] Enter/Space activates buttons and links
- [ ] Escape dismisses modals/menus
- [ ] No keyboard traps

### Step 2: Focus Indicators
- [ ] Focus outline visible on ALL interactive elements
- [ ] Focus indicator high contrast (4.5:1 minimum)
- [ ] Focus outline at least 2px
- [ ] Focus visible in all viewport sizes

### Step 3: Color & Contrast
- [ ] Text-to-background 4.5:1 minimum
- [ ] Large text (18pt+) 3:1 minimum
- [ ] UI components 3:1 minimum
- [ ] Color not sole method of information
- [ ] Sufficient contrast in all states (normal, hover, focus, active)

### Step 4: Screen Reader Testing
- [ ] All interactive elements announced
- [ ] Form labels announced with inputs
- [ ] Headings announce structure
- [ ] Images have meaningful alt text
- [ ] Skip navigation links available

### Step 5: Mobile & Touch
- [ ] Touch targets 44x44 pixels minimum
- [ ] Touch spacing adequate
- [ ] Gestures not required for functionality
- [ ] Pinch/zoom not disabled

### Step 6: Heading Structure
- [ ] H1 present and unique per page
- [ ] Heading hierarchy logical (no skipping H1→H3)
- [ ] Headings describe section purpose
- [ ] No heading markup used for styling

### Step 7: Forms
- [ ] All form fields have labels
- [ ] Labels properly associated (for attribute)
- [ ] Error messages identified and descriptive
- [ ] Help text associated with inputs
- [ ] Required fields marked in multiple ways

## Common Accessibility Issues

**DO NOT:**
- Use color alone to indicate state/information
- Rely on mouse-only interactions
- Disable zoom functionality
- Have invisible focus indicators
- Create keyboard traps
- Use images of text
- Have auto-playing audio
- Use placeholder text as label
- Require specific timing/gestures

**DO:**
- Provide keyboard alternatives
- Maintain visible focus indicators
- Use semantic HTML elements
- Provide descriptive alt text
- Ensure sufficient color contrast
- Label form inputs properly
- Allow text resizing
- Keep content simple and clear
