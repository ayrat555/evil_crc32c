use rustler::{Binary, NifResult};

rustler::init!("Elixir.EvilCrc32c.Impl", [calc]);

// 0x82f63b78 as i32;
const POLY: i32 = -2097792136i32;
// 0xffffffff as i32
const FFFFFFFF: i32 = -1i32;

#[rustler::nif]
fn calc<'a>(payload: Binary<'a>) -> NifResult<i32> {
    let mut crc = 0 ^ FFFFFFFF;

    for payload_byte in payload.as_slice() {
        crc = crc ^ (*payload_byte as i32);

        for _i in 0..8 {
            crc = if crc & 1 > 0 {
                unsigned_right_shift(crc, 1) ^ POLY
            } else {
                unsigned_right_shift(crc, 1)
            };
        }
    }

    crc = crc ^ FFFFFFFF;

    Ok(crc)
}

fn unsigned_right_shift(a: i32, b: u32) -> i32 {
    ((a as u32) >> b) as i32
}
