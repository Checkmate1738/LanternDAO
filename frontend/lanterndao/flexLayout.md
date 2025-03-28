Flexbox (Flexible Box Layout) is a CSS layout module designed to provide a more efficient way to arrange items in a container. It enables alignment, spacing, and responsiveness of child elements without relying heavily on floats or positioning. Below is a breakdown of **flexbox properties** and their attributes:

---

### 1. **Container Properties**
These are applied to the parent element that has `display: flex` or `display: inline-flex`.

#### **`display`**
- **`flex`**: Defines a block-level flex container.
- **`inline-flex`**: Defines an inline flex container.

#### **`flex-direction`**
Specifies the direction of the main axis (how items are placed in the container).
- **`row`** (default): Left-to-right (or right-to-left in RTL languages).
- **`row-reverse`**: Right-to-left (or left-to-right in RTL languages).
- **`column`**: Top-to-bottom.
- **`column-reverse`**: Bottom-to-top.

#### **`flex-wrap`**
Determines whether flex items should wrap onto multiple lines.
- **`nowrap`** (default): All items are on one line.
- **`wrap`**: Items wrap onto multiple lines.
- **`wrap-reverse`**: Wrap items in reverse order.

#### **`flex-flow`**
Shorthand for `flex-direction` and `flex-wrap`.
- Example: `flex-flow: row wrap;`

#### **`justify-content`**
Aligns items along the main axis.
- **`flex-start`** (default): Items align to the start of the main axis.
- **`flex-end`**: Items align to the end of the main axis.
- **`center`**: Items are centered along the main axis.
- **`space-between`**: Equal spacing between items; first and last items are at the container's edges.
- **`space-around`**: Equal spacing around items, including half-spacing at the container's edges.
- **`space-evenly`**: Equal spacing between items and the container edges.

#### **`align-items`**
Aligns items along the cross axis.
- **`stretch`** (default): Items stretch to fill the container.
- **`flex-start`**: Items align to the start of the cross axis.
- **`flex-end`**: Items align to the end of the cross axis.
- **`center`**: Items are centered along the cross axis.
- **`baseline`**: Items align along their text baselines.

#### **`align-content`**
Aligns a multi-line flex container along the cross axis. (Only applies when `flex-wrap` is set to `wrap` or `wrap-reverse`.)
- **`stretch`** (default): Lines stretch to fill the container.
- **`flex-start`**: Lines align to the start of the cross axis.
- **`flex-end`**: Lines align to the end of the cross axis.
- **`center`**: Lines are centered along the cross axis.
- **`space-between`**: Equal spacing between lines.
- **`space-around`**: Equal spacing around lines.

---

### 2. **Item Properties**
These are applied to the child elements within a flex container.

#### **`order`**
Specifies the order of items. Default is `0`. Lower values appear first.
- Example: `order: 1;`

#### **`flex-grow`**
Defines how much space an item should take up relative to others. Default is `0` (no growth).
- Example: `flex-grow: 2;` (This item takes twice as much space as an item with `flex-grow: 1`.)

#### **`flex-shrink`**
Defines how much an item should shrink relative to others when there isn’t enough space. Default is `1`.
- Example: `flex-shrink: 0;` (This item won't shrink.)

#### **`flex-basis`**
Defines the initial size of an item before `flex-grow` or `flex-shrink` are applied. Default is `auto`.
- Examples: `flex-basis: 50px;`, `flex-basis: 30%;`

#### **`flex`**
Shorthand for `flex-grow`, `flex-shrink`, and `flex-basis`.
- Examples:
  - `flex: 1;` (equivalent to `flex-grow: 1; flex-shrink: 1; flex-basis: 0%;`)
  - `flex: 0 0 100px;` (equivalent to `flex-grow: 0; flex-shrink: 0; flex-basis: 100px;`)

#### **`align-self`**
Overrides `align-items` for a specific item, aligning it along the cross axis.
- **`auto`** (default): Inherits `align-items` value.
- **`flex-start`**: Aligns to the start of the cross axis.
- **`flex-end`**: Aligns to the end of the cross axis.
- **`center`**: Centers the item along the cross axis.
- **`baseline`**: Aligns the item to its text baseline.
- **`stretch`**: Stretches the item to fill the container.

---

### Example Usage
```html
<div style="display: flex; flex-direction: row; justify-content: space-between; align-items: center; height: 100px;">
  <div style="flex: 1;">Item 1</div>
  <div style="flex: 2;">Item 2</div>
  <div style="flex: 1;">Item 3</div>
</div>
```

### Visualizing the Attributes
- **Main axis**: The direction defined by `flex-direction`.
- **Cross axis**: Perpendicular to the main axis.
