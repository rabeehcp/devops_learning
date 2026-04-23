# test_calculator.py — Tests for our calculator

import pytest
from calculator import add, subtract, multiply, divide, is_even

# ── ADD TESTS ──────────────────────────
def test_add_positive():
    assert add(2, 3) == 5

def test_add_negative():
    assert add(-1, -1) == -2

def test_add_zero():
    assert add(0, 5) == 5

# ── SUBTRACT TESTS ─────────────────────
def test_subtract():
    assert subtract(10, 3) == 7

def test_subtract_negative():
    assert subtract(5, 10) == -5

# ── MULTIPLY TESTS ─────────────────────
def test_multiply():
    assert multiply(4, 5) == 20

def test_multiply_zero():
    assert multiply(5, 0) == 0

# ── DIVIDE TESTS ───────────────────────
def test_divide():
    assert divide(10, 2) == 5.0

def test_divide_by_zero():
    # This should raise an error
    with pytest.raises(ValueError):
        divide(10, 0)

# ── IS EVEN TESTS ──────────────────────
def test_is_even_true():
    assert is_even(4) == True

def test_is_even_false():
    assert is_even(3) == False
