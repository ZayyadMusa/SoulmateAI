---
name: Companion System
colors:
  surface: '#f7f9fc'
  surface-dim: '#d8dadd'
  surface-bright: '#f7f9fc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f7'
  surface-container: '#eceef1'
  surface-container-high: '#e6e8eb'
  surface-container-highest: '#e0e3e6'
  on-surface: '#191c1e'
  on-surface-variant: '#414751'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f4'
  outline: '#727782'
  outline-variant: '#c1c6d3'
  surface-tint: '#075fab'
  primary: '#075fab'
  on-primary: '#ffffff'
  primary-container: '#5d9cec'
  on-primary-container: '#003260'
  inverse-primary: '#a4c9ff'
  secondary: '#845400'
  on-secondary: '#ffffff'
  secondary-container: '#feb246'
  on-secondary-container: '#6f4600'
  tertiary: '#3a6a00'
  on-tertiary: '#ffffff'
  tertiary-container: '#61ac00'
  on-tertiary-container: '#1c3900'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d4e3ff'
  primary-fixed-dim: '#a4c9ff'
  on-primary-fixed: '#001c39'
  on-primary-fixed-variant: '#004884'
  secondary-fixed: '#ffddb6'
  secondary-fixed-dim: '#ffb95a'
  on-secondary-fixed: '#2a1800'
  on-secondary-fixed-variant: '#643f00'
  tertiary-fixed: '#a1fa49'
  tertiary-fixed-dim: '#87dc2c'
  on-tertiary-fixed: '#0e2000'
  on-tertiary-fixed-variant: '#2a5000'
  background: '#f7f9fc'
  on-background: '#191c1e'
  surface-variant: '#e0e3e6'
typography:
  headline-lg:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Plus Jakarta Sans
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 30px
  body-lg:
    fontFamily: Be Vietnam Pro
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Be Vietnam Pro
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Plus Jakarta Sans
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 8px
  container-margin: 24px
  gutter: 16px
  section-gap: 40px
---

## Brand & Style

The brand personality is rooted in empathy, warmth, and reliable companionship. It aims to evoke an emotional response of being "seen" and supported, shifting the perception of AI from a utility to a supportive presence. The target audience includes individuals seeking emotional wellness, habit tracking, or a calm digital space for reflection.

The design style is **Soft Minimalist with Tactile accents**. It prioritizes extreme clarity and breathing room to reduce cognitive load. By blending organic shapes with a high-quality typographic hierarchy, the UI feels intentional and human. It avoids the coldness of traditional tech by utilizing subtle gradients and soft transitions that mimic natural light.

## Colors

The palette is designed to be "soothing yet optimistic." 

- **Primary (Gentle Blue):** Used for main interactions and the "voice" of the companion. It represents trust and calm.
- **Secondary (Warm Amber):** Used for highlights, achievements, and "sunshine" moments. It adds a glow of friendliness.
- **Tertiary (Soothing Green):** Reserved for growth, health, and positive affirmations.
- **Neutral:** A range of soft off-whites and cool grays that prevent the interface from feeling clinical or "pure white."

Color should be applied with low saturation and high value to maintain a "paper-like" softness. Avoid harsh black (#000000); use deep navy-grays for text to keep the contrast accessible but gentle.

## Typography

This design system uses a combination of **Plus Jakarta Sans** for structure and **Be Vietnam Pro** for conversation. 

The headline font (Plus Jakarta Sans) provides a modern, friendly geometric feel with soft terminals that align with the brand’s "lovable" nature. The body font (Be Vietnam Pro) is chosen for its exceptional readability and contemporary warmth, making long-form chat or reflections feel personal and approachable.

Letter spacing is slightly tightened on headlines to create a cohesive "unit" feel, while body text is given generous line-height to ensure a relaxed reading pace.

## Layout & Spacing

The layout philosophy follows a **Fluid Grid with Generous Margins**. It avoids density at all costs.

- **Mobile:** A single-column layout with 24px side margins. Elements are stacked with 16px to 24px of vertical padding to ensure touch targets are easy to hit.
- **Desktop/Tablet:** A centered 12-column max-width container (1120px). Use wide gutters (24px+) to allow the content to breathe.

Whitespace is treated as a core design element, not just "empty space." Large gaps (40px+) should be used to separate different emotional contexts, such as moving from a "Daily Check-in" to "Historical Insights."

## Elevation & Depth

Visual hierarchy is established through **Tonal Layers and Ambient Shadows**. 

Instead of traditional heavy shadows, this design system uses "Light Glows." Surface depth is indicated by shifting from a neutral background to a pure white surface. When an element needs to be "raised" (like a primary action card), use a very large blur radius (32px+) with a low-opacity color tint derived from the primary brand color (e.g., a 4% blue-tinted shadow).

Avoid borders where possible; let the subtle difference in background tone or a very soft shadow define the edges of containers.

## Shapes

The shape language is **distinctly rounded and organic**. 

Sharp corners are entirely avoided to maintain a non-robotic, friendly atmosphere. Standard UI components use a 0.5rem radius, while larger containers and cards utilize the `rounded-xl` (1.5rem) setting. This creates a "pebble-like" feel—smooth, safe, and comfortable to hold. Interaction states (like hovering or pressing) should animate the roundness or scale slightly to emphasize the tactile, responsive nature of the companion.

## Components

- **Buttons:** Use high-radius (fully rounded/pill-shaped) buttons. The primary button should have a subtle gradient to give it a 3D "pressable" feel. Avoid "Ghost" buttons with borders; use soft-tinted backgrounds instead.
- **Cards:** Cards should have a white background with a very soft, tinted ambient shadow. No borders. Use 24px internal padding for a spacious feel.
- **Input Fields:** Fields should be represented by soft-gray recessed shapes. The focus state should glow with the primary blue color rather than a hard stroke.
- **Chips:** Used for quick-reply suggestions in chat. These are small, pill-shaped, and use the secondary or tertiary colors at 10% opacity for a subtle, inviting look.
- **The "Companion" Avatar:** This component is always present. It should be a fluid, morphing shape (blob-like) that changes color or pulse-rate based on the emotional context of the conversation.
- **Lists:** Use generous vertical spacing between items. Each list item should be separated by a wide gap rather than a thin line divider to maintain the clean aesthetic.