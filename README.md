# Pico8

A collection of PICO-8 carts hosted on GitHub Pages.

## Adding Carts

1. Export your PICO-8 cart to HTML:
   - In PICO-8, load your cart: `load cart_name`
   - Export to HTML: `export cart_name.html`
     - This creates `cart_name.html` and `cart_name.js` in `~/.lexaloffle/pico-8/carts/`
   - Export a screenshot for cartridge artwork by pressing `F7` in game and running `save cart_name.png`
     - This creates cart named `cart_name.p8.png`, which is a fully distributable PICO-8 game on it's own!

2. Add the cart name to the `CARTS` variable in `Makefile`:
   ```makefile
   CARTS := cave your_new_cart
   ```

3. Copy carts to the project:
   ```bash
   make copy-carts
   ```

4. Update `index.html` to add your new cart to the grid:
   ```html
   <a href="carts/your_new_cart/index.html" class="cart-item">
       <img src="carts/your_new_cart/your_new_cart.p8.png" alt="Your Cart Name" class="cart-image">
       <div class="cart-name">Your Cart Name</div>
   </a>
   ```

5. Commit and push:
   ```bash
   git add .
   git commit -m "Add new cart: your_new_cart"
   git push
   ```

## Local Development

Open `index.html` in your browser to view the cart gallery.

To play a specific cart locally, open `carts/cart_name/index.html`.

## Deployment

This site deploys automatically to GitHub Pages when pushed to the main branch.

## Makefile Commands

- `make copy-carts` - Copy carts from PICO-8 directory to project
- `make clean` - Remove all carts from project directory
- `make help` - Show help message
