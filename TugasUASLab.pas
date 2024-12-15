program BlackMarket;

uses crt;

type
    TBarang = record
        nama: string;
        harga: real;
        stok: integer;
    end;

const
    MaksBarang = 100;
    TarifOngkosKirim = 7000;

var
    inventori: array[1..MaksBarang] of TBarang;
    pilihan, jumlahBarang: integer;
    totalHargaBarang, totalHargaAkhir, ongkosKirim: real;

procedure TampilkanInventori;
var
    i: integer;
begin
    clrscr;
    writeln('=== Daftar Inventori Black Market ===');
    writeln(' No  | Nama Barang         | Harga       | Stok');
    writeln('-----------------------------------------------');
    for i := 1 to jumlahBarang do
    begin
        writeln(i:3, '  | ', inventori[i].nama:18, ' | Rp ', inventori[i].harga:10:2, ' | ', inventori[i].stok:4);
    end;
    writeln('-----------------------------------------------');
    writeln;
end;

procedure TambahBarang;
var
    namaBarang: string;
    hargaBarang: real;
    stokBarang, i: integer;
    barangDitemukan: boolean;
begin
    clrscr;
    barangDitemukan := False;
    write('Masukkan nama barang: ');
    readln(namaBarang);

    for i := 1 to jumlahBarang do
    begin
        if inventori[i].nama = namaBarang then
        begin
            barangDitemukan := True;
            write('Barang ditemukan! Masukkan jumlah stok yang ingin ditambahkan: ');
            readln(stokBarang);
            if stokBarang > 0 then
            begin
                inventori[i].stok := inventori[i].stok + stokBarang;
                writeln('Stok barang "', namaBarang, '" berhasil ditambahkan.');
            end
            else
                writeln('Jumlah stok harus lebih dari 0.');
            break;
        end;
    end;

    if not barangDitemukan then
    begin
        if jumlahBarang < MaksBarang then
        begin
            inc(jumlahBarang);
            inventori[jumlahBarang].nama := namaBarang;
            write('Masukkan harga barang: ');
            readln(hargaBarang);
            if hargaBarang > 0 then
            begin
                inventori[jumlahBarang].harga := hargaBarang;
                write('Masukkan jumlah stok barang: ');
                readln(stokBarang);
                if stokBarang > 0 then
                begin
                    inventori[jumlahBarang].stok := stokBarang;
                    writeln('Barang "', namaBarang, '" berhasil ditambahkan ke inventori.');
                end
                else
                    writeln('Stok barang harus lebih dari 0.');
            end
            else
                writeln('Harga barang harus lebih dari 0.');
        end
        else
            writeln('Inventori penuh, tidak bisa menambah barang baru.');
    end;
    writeln;
end;

procedure BeliBarang;
var
    idx, jumlahBeli, jarak: integer;
    subtotal: real;
begin
    clrscr;
    totalHargaBarang := 0.0;
    TampilkanInventori;
    write('Pilih nomor barang yang ingin dibeli (0 untuk selesai): ');
    readln(idx);

    while idx <> 0 do
    begin
        if (idx >= 1) and (idx <= jumlahBarang) then
        begin
            write('Masukkan jumlah yang ingin dibeli: ');
            readln(jumlahBeli);
            if (jumlahBeli > 0) and (jumlahBeli <= inventori[idx].stok) then
            begin
                subtotal := jumlahBeli * inventori[idx].harga;
                totalHargaBarang := totalHargaBarang + subtotal;
                inventori[idx].stok := inventori[idx].stok - jumlahBeli;
                writeln('Subtotal untuk "', inventori[idx].nama, '": Rp ', subtotal:0:2);
            end
            else
                writeln('Jumlah tidak valid atau stok tidak mencukupi.');
        end
        else
            writeln('Nomor barang tidak valid.');

        write('Pilih nomor barang lain untuk dijual (0 untuk selesai): ');
        readln(idx);
    end;

    write('Masukkan jarak pengiriman (km): ');
    readln(jarak);
    if jarak > 0 then
    begin
        ongkosKirim := jarak * TarifOngkosKirim;
        totalHargaAkhir := totalHargaBarang + ongkosKirim;
        writeln('Total harga barang yang dijual: Rp ', totalHargaBarang:0:2);
        writeln('Total ongkos kirim: Rp ', ongkosKirim:0:2);
        writeln('Total pembayaran: Rp ', totalHargaAkhir:0:2);
    end
    else
        writeln('Jarak pengiriman tidak valid.');

    writeln('Tekan ENTER untuk kembali ke menu utama...');
    readln;
end;

begin
    clrscr;
    jumlahBarang := 3;

    inventori[1].nama := 'AK-47';
    inventori[1].harga := 3500000;
    inventori[1].stok := 7;

    inventori[2].nama := 'Desert Eagle';
    inventori[2].harga := 1500000;
    inventori[2].stok := 5;

    inventori[3].nama := 'Katana';
    inventori[3].harga := 2500000;
    inventori[3].stok := 3;

    repeat
        clrscr;
        writeln('=== Menu Utama Black Market ===');
        writeln('1. Tampilkan Inventori');
        writeln('2. Jual Barang');
        writeln('3. Tambah Barang');
        writeln('4. Keluar');
        write('Pilih opsi: ');
        readln(pilihan);

        case pilihan of
            1: 
                begin
                    TampilkanInventori;
                    writeln('Tekan ENTER untuk kembali ke menu utama...');
                    readln;
                end;
            2: BeliBarang;
            3: TambahBarang;
            4: 
                begin
                    writeln('Terima kasih telah menggunakan Black Market.');
                    halt;
                end;
            else
                writeln('Pilihan tidak valid.');
        end;
    until pilihan = 4;
end.