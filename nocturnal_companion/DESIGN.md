---
name: Nocturnal Companion
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#c1c6d3'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#8b919c'
  outline-variant: '#414751'
  surface-tint: '#a4c9ff'
  primary: '#a4c9ff'
  on-primary: '#00315d'
  primary-container: '#5d9cec'
  on-primary-container: '#003260'
  inverse-primary: '#075fab'
  secondary: '#b5c8df'
  on-secondary: '#203243'
  secondary-container: '#36485b'
  on-secondary-container: '#a4b7cd'
  tertiary: '#a4c9ff'
  on-tertiary: '#00315d'
  tertiary-container: '#589cef'
  on-tertiary-container: '#00325f'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a4c9ff'
  on-primary-fixed: '#001c39'
  on-primary-fixed-variant: '#004884'
  secondary-fixed: '#d1e4fb'
  secondary-fixed-dim: '#b5c8df'
  on-secondary-fixed: '#091d2e'
  on-secondary-fixed-variant: '#36485b'
  tertiary-fixed: '#d4e3ff'
  tertiary-fixed-dim: '#a4c9ff'
  on-tertiary-fixed: '#001c39'
  on-tertiary-fixed-variant: '#004883'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  headline-xl:
    fontFamily: Be Vietnam Pro
    fontSize: 40px
    fontWeight: '700'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Be Vietnam Pro
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Be Vietnam Pro
    fontSize: 28px
    fontWeight: '600'
    lineHeight: 34px
  body-md:
    fontFamily: Be Vietnam Pro
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Be Vietnam Pro
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Be Vietnam Pro
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 40px
  gutter: 16px
  margin-mobile: 16px
  margin-desktop: 64px
---

## Brand & Style

The design system shifts into a "Night Mode" ethos, transitioning from a bright daytime assistant to a calm, focused nocturnal companion. The brand personality remains friendly and approachable but adopts a more subdued, protective tone designed for low-light environments and long-term engagement.

The aesthetic blends **Minimalism** with subtle **Glassmorphism**. By using deep charcoal and navy foundations, the interface minimizes eye strain while maintaining a sense of depth. The emotional response is one of safety, sophistication, and quiet reliability—evoking the feeling of a high-end digital concierge that is present but never intrusive.

## Colors

The palette is anchored in a deep, layered dark theme. The base background utilizes a "true dark" charcoal (#121212) to ensure perfect contrast, while interactive surfaces use a slightly lighter navy-charcoal (#1E1E1E) to create a sense of elevation.

The primary accent is a soft, luminous blue (#5D9CEC). This color is reserved for critical interaction points, active states, and brand-defining moments. Text roles are strictly enforced for legibility: pure white for headings and high-emphasis data, and a soft, desaturated grey (#B0B0B0) for body copy and secondary metadata. Subtle gradients are applied to primary buttons, moving from the primary blue to a slightly deeper tone to maintain the "warm" tactile feel.

## Typography

The design system utilizes **Be Vietnam Pro** across all roles to maintain a contemporary, friendly, and geometric appearance that performs exceptionally well in dark mode. The typeface’s open apertures ensure that light text on dark backgrounds remains crisp and does "bloom" or become difficult to read.

Headlines use tighter letter spacing and heavier weights to establish a clear hierarchy against the dark canvas. Body text is set with generous line heights to enhance readability during extended sessions. Labels and small captions utilize a slightly increased letter spacing and semi-bold weights to ensure they don't disappear against the deep backgrounds.

## Layout & Spacing

The design system follows a **Fluid Grid** philosophy based on an 8px spacing rhythm. This ensures that even in a dark environment, where visual boundaries are softer, the structural alignment remains rigid and professional.

For mobile, a 4-column layout is used with 16px side margins. On desktop, the system expands to a 12-column grid with a maximum content width of 1280px. Negative space is used aggressively to prevent the dark interface from feeling cramped or "heavy." Components are separated by generous margins (24px+) to allow the subtle surface glows and shadows to breathe without overlapping.

## Elevation & Depth

Depth in this dark mode iteration is achieved through **Tonal Layering** and **Ambient Shadows**. 

1.  **Level 0 (Base):** #121212. Used for the primary background.
2.  **Level 1 (Card/Surface):** #1E1E1E. Used for main content containers. These feature a subtle 1px inner border (opacity 5% white) to define edges against the base.
3.  **Level 2 (Overlay/Menu):** #252525. Used for floating elements.

Shadows are not black; they are deep navy-tinted blurs with low opacity (e.g., `0 8px 24px rgba(0,0,0,0.5)`). For the "warm" effect, primary interactive elements (like active buttons) emit a soft #5D9CEC outer glow (5-10% opacity) to simulate a gentle luminescence.

## Shapes

The design system uses a **Rounded** shape language to maintain the "companion" feel. Standard components feature an 8px (0.5rem) corner radius. Larger containers, such as feature cards or modals, utilize "rounded-lg" (16px) or "rounded-xl" (24px) to soften the overall geometry of the screen. This roundness counteracts the inherent "coldness" of dark mode palettes, ensuring the UI remains inviting.

## Components

### Buttons
Primary buttons feature a soft gradient of #5D9CEC to #4A90E2 with white text. Secondary buttons use a "ghost" style with a 1px border of #5D9CEC and no fill. All buttons use 8px rounded corners and a slight scale-down effect (98%) on press.

### Input Fields
Fields are rendered in #1E1E1E with a subtle 1px border (#2C3E50). Upon focus, the border transitions to #5D9CEC with a soft outer glow. Placeholder text is set in #B0B0B0 at 60% opacity.

### Cards
Cards use the Level 1 surface color (#1E1E1E). They do not use heavy shadows; instead, they rely on the tonal difference and a very thin, low-opacity border to separate themselves from the Level 0 background.

### Chips & Tags
Chips are pill-shaped (24px radius) and use a semi-transparent version of the primary blue (15% opacity) with #5D9CEC text for a "glass" look.

### Lists
List items are separated by subtle dividers (#FFFFFF at 5% opacity). Active or selected states in a list use a soft #5D9CEC left-accent bar (4px width).