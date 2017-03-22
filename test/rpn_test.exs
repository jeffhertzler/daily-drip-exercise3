defmodule RpnTest do
  use ExUnit.Case

  setup context do
    {:ok, rpn} = Rpn.start_link([[name: context.test]])
    {:ok, rpn: rpn}
  end

  test "starts with an empty stack", context do
    assert Rpn.peek(context.rpn) == []
  end

  test "pushing onto the stack", context do
    Rpn.push(context.rpn, 5)
    assert Rpn.peek(context.rpn) == [5]
    Rpn.push(context.rpn, 1)
    assert Rpn.peek(context.rpn) == [1, 5]
  end

  test "adding", context do
    Rpn.push(context.rpn, 5)
    Rpn.push(context.rpn, 1)
    Rpn.push(context.rpn, :+)
    assert Rpn.peek(context.rpn) == [6]
  end

  test "subtracting", context do
    Rpn.push(context.rpn, 5)
    Rpn.push(context.rpn, 1)
    Rpn.push(context.rpn, :-)
    assert Rpn.peek(context.rpn) == [4]
  end

  test "multiplying", context do
    Rpn.push(context.rpn, 5)
    Rpn.push(context.rpn, 2)
    Rpn.push(context.rpn, :x)
    assert Rpn.peek(context.rpn) == [10]
  end

  test "wikipedia example", context do
    Rpn.push(context.rpn, 5)
    Rpn.push(context.rpn, 1)
    Rpn.push(context.rpn, 2)
    Rpn.push(context.rpn, :+)
    Rpn.push(context.rpn, 4)
    Rpn.push(context.rpn, :x)
    Rpn.push(context.rpn, :+)
    Rpn.push(context.rpn, 3)
    Rpn.push(context.rpn, :-)
    assert Rpn.peek(context.rpn) == [14]
  end

  test "dividing", context do
    Rpn.push(context.rpn, 4)
    Rpn.push(context.rpn, 2)
    Rpn.push(context.rpn, :/)
    assert Rpn.peek(context.rpn) == [2]
  end
end
