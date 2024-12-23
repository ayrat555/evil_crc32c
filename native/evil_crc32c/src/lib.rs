use rustler::{Binary, NifResult};

rustler::init!("Elixir.EvilCrc32c.Impl");

// 0x82f63b78 as i32;
const POLY_CRC32C: i32 = -2097792136i32;
// 0xffffffff as i32
const FFFFFFFF_CRC32C: i32 = -1i32;

const POLY_CRC16: i32 = 0x1021;
const MASK_CRC16: i32 = 0x80;
const FFFF_CRC16: i32 = 0xffff;

#[rustler::nif]
fn calc_crc32c<'a>(payload: Binary<'a>) -> NifResult<i32> {
    let mut crc = 0 ^ FFFFFFFF_CRC32C;

    for payload_byte in payload.as_slice() {
        crc = crc ^ (*payload_byte as i32);

        for _i in 0..8 {
            crc = if crc & 1 > 0 {
                unsigned_right_shift(crc, 1) ^ POLY_CRC32C
            } else {
                unsigned_right_shift(crc, 1)
            };
        }
    }

    crc = crc ^ FFFFFFFF_CRC32C;

    Ok(crc)
}

#[rustler::nif]
fn calc_crc16<'a>(payload: Binary<'a>) -> NifResult<i32> {
    let mut extended_payload: Vec<u8> = vec![];
    extended_payload.extend_from_slice(payload.as_slice());
    extended_payload.append(&mut vec![0, 0]);

    let mut reg: i32 = 0;
    for payload_byte in extended_payload {
        let mut mask = MASK_CRC16;

        while mask > 0 {
            reg = reg << 1;

            if ((payload_byte as i32) & mask) > 0 {
                reg = reg + 1;
            }

            mask = mask >> 1;

            if reg > FFFF_CRC16 {
                reg = reg & FFFF_CRC16;
                reg = reg ^ POLY_CRC16;
            }
        }
    }

    Ok(reg)
}

fn unsigned_right_shift(a: i32, b: u32) -> i32 {
    ((a as u32) >> b) as i32
}
