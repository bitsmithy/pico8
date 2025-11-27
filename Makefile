# Makefile for PICO-8 carts website
# Copies exported PICO-8 carts from the PICO-8 directory to the project

PICO8_CARTS_DIR := $(HOME)/.lexaloffle/pico-8/carts
PROJECT_CARTS_DIR := ./carts

# Automatically detect carts from the carts directory
CARTS := $(shell find $(PROJECT_CARTS_DIR) -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null)

# Targets
.PHONY: all copy-carts help launch

all: copy-carts

help:
	@echo "PICO-8 Carts Website Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make copy-carts    - Copy carts from PICO-8 directory and show HTML"
	@echo "  make launch        - Open index.html in your default browser"
	@echo "  make clean         - Remove all carts from project directory"
	@echo "  make help          - Show this help message"
	@echo ""
	@echo "Detected carts: $(CARTS)"
	@echo ""
	@echo "To add a new cart:"
	@echo "  1. Export your cart to HTML from PICO-8"
	@echo "  2. Run 'make copy-carts CARTS=cartname'"
	@echo "  3. Copy the HTML output and paste into index.html"

copy-carts:
	@echo "Copying carts from $(PICO8_CARTS_DIR)..."
	@for cart in $(CARTS); do \
		echo "Processing $$cart..."; \
		mkdir -p $(PROJECT_CARTS_DIR)/$$cart; \
		if [ -f "$(PICO8_CARTS_DIR)/$$cart.html" ]; then \
			cp "$(PICO8_CARTS_DIR)/$$cart.html" "$(PROJECT_CARTS_DIR)/$$cart/index.html"; \
			echo "  ✓ Copied $$cart.html -> $$cart/index.html"; \
		else \
			echo "  ✗ Warning: $$cart.html not found"; \
		fi; \
		if [ -f "$(PICO8_CARTS_DIR)/$$cart.js" ]; then \
			cp "$(PICO8_CARTS_DIR)/$$cart.js" "$(PROJECT_CARTS_DIR)/$$cart/$$cart.js"; \
			echo "  ✓ Copied $$cart.js"; \
		else \
			echo "  ✗ Warning: $$cart.js not found"; \
		fi; \
		if [ -f "$(PICO8_CARTS_DIR)/$$cart.p8.png" ]; then \
			cp "$(PICO8_CARTS_DIR)/$$cart.p8.png" "$(PROJECT_CARTS_DIR)/$$cart/$$cart.p8.png"; \
			echo "  ✓ Copied $$cart.p8.png"; \
		fi; \
	done
	@echo ""
	@echo "Done! Copy the HTML below into index.html:"
	@echo ""
	@echo "=========================================="
	@for cart in $(CARTS); do \
		cart_name=$$(echo $$cart | sed 's/.*/\u&/'); \
		echo "<div class=\"cart-item\">"; \
		echo "  <a href=\"carts/$$cart/index.html\">"; \
		echo "    <img src=\"carts/$$cart/$$cart.p8.png\" alt=\"$$cart_name\" class=\"cart-image\">"; \
		echo "    <div class=\"cart-name\">$$cart_name</div>"; \
		echo "  </a>"; \
		echo "  <div class=\"cart-comment\"><!-- Add your custom comment here --></div>"; \
		echo "</div>"; \
	done
	@echo "=========================================="

launch:
	@echo "Opening index.html in browser..."
	@xdg-open index.html 2>/dev/null || open index.html
