// Copyright 2024 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

pub fn Int::from_int(i : Int) -> Int {
  i
}

pub fn abs(self : Int) -> Int {
  if self < 0 {
    -self
  } else {
    self
  }
}

pub fn signum(self : Int) -> Int {
  if self < 0 {
    -1
  } else if self > 0 {
    1
  } else {
    0
  }
}

fn test_num[T : @num.Num + Debug + Default + Eq](
  x : T,
  y : T,
  x_plus_y : T,
  x_mul_y : T,
  x_minus_y : T,
  x_div_y : T,
  x_signum : T
) -> Result[Unit, String] {
  @assertion.assert_eq(x + y, x_plus_y)?
  @assertion.assert_eq(x * y, x_mul_y)?
  @assertion.assert_eq(x - y, x_minus_y)?
  @assertion.assert_eq(x / y, x_div_y)?
  @assertion.assert_eq(x.abs(), T::default() - x)?
  @assertion.assert_eq(x.signum(), x_signum)?
  Ok(())
}

test "int.num" {
  let x = -5
  let y = 7
  test_num(x, y, x + y, x * y, x - y, x / y, -1)?
}

pub fn to_string(self : Int) -> String {
  fn abs(n : Int) -> Int {
    if n < 0 {
      0 - n
    } else {
      n
    }
  }

  // The min and max value of i32 are -2147483648 and 2147483647,
  // so max=11 is enough.
  let buf = Buffer::make(11)

  if self < 0 {
    buf.write_char('-')
  }

  fn write_digits(num) {
    let num2 = num / 10
    if num2 != 0 {
      write_digits(num2)
    }
    buf.write_char(Char::from_int((abs(num % 10) + 48)))
  }

  write_digits(self)

  buf.to_string()
}
