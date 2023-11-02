codeunit 50100 "RLU Kreatif Global Code"
{
    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, '')
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div Power(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, 'Ratus');
                end;
                if ((Tens > 0) or (Ones > 0)) and (Hundreds > 0) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, '');
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;

            AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        end;

        if No > 0 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Format(No * 100))
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ');
        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);

    end;


    procedure GetAmtDecimalPosition(): Decimal
    begin
        IF GenJournalLine."Currency Code" = '' THEN
            Currency.InitRoundingPrecision()
        ELSE BEGIN
            Currency.GET(GenJournalLine."Currency Code");
            Currency.TESTFIELD("Amount Rounding Precision");
        END;

        EXIT(1 / Currency."Amount Rounding Precision");
    end;

    procedure AddToNoText(VAR NoText: ARRAY[2] OF Text; VAR NoTextIndex: Integer; VAR PrintExponent: Boolean; AddText: Text)
    begin
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR('', AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure BulanIndonesia(Tanggal: Date) resullt: Text
    var
        _ReturnDisplay: Text;
        _DateOrig: Text;
        _MonthOrig: Text;
        _YearOrig: Text;
    begin
        _DateOrig := Format(DATE2DMY(Tanggal, 1));
        _MonthOrig := Format(DATE2DMY(Tanggal, 2));
        _YearOrig := Format(DATE2DMY(Tanggal, 3));
        case _MonthOrig of
            '01':

                _ReturnDisplay := _DateOrig + ' Januari ' + _YearOrig;

            '02':

                _ReturnDisplay := _DateOrig + ' Februari ' + _YearOrig;

            '03':

                _ReturnDisplay := _DateOrig + ' Maret ' + _YearOrig;

            '04':

                _ReturnDisplay := _DateOrig + ' April ' + _YearOrig;

            '05':

                _ReturnDisplay := _DateOrig + ' Mei ' + _YearOrig;

            '06':

                _ReturnDisplay := _DateOrig + ' Juni ' + _YearOrig;

            '07':

                _ReturnDisplay := _DateOrig + ' Juli ' + _YearOrig;

            '08':

                _ReturnDisplay := _DateOrig + ' Agustus ' + _YearOrig;

            '09':

                _ReturnDisplay := _DateOrig + ' September ' + _YearOrig;

            '10':

                _ReturnDisplay := _DateOrig + ' Oktober ' + _YearOrig;

            '11':

                _ReturnDisplay := _DateOrig + ' November ' + _YearOrig;

            '12':

                _ReturnDisplay := _DateOrig + ' Desember ' + _YearOrig;

        end;

        exit(_ReturnDisplay)
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := 'Satu';
        OnesText[2] := 'Dua';
        OnesText[3] := 'Tiga';
        OnesText[4] := 'Empat';
        OnesText[5] := 'Lima';
        OnesText[6] := 'Enam';
        OnesText[7] := 'Tujuh';
        OnesText[8] := 'Delapan';
        OnesText[9] := 'Sembilan';
        OnesText[10] := 'Sepuluh';
        OnesText[11] := 'Sebelas';
        OnesText[12] := 'Dua Belas';
        OnesText[13] := 'Tiga Belas';
        OnesText[14] := 'Empat Belas';
        OnesText[15] := 'Lima Belas';
        OnesText[16] := 'Enam Belas';
        OnesText[17] := 'Tujuh Belas';
        OnesText[18] := 'Delapan Belas';
        OnesText[19] := 'Sembilan Belas';

        TensText[1] := 'Not used';
        TensText[2] := 'Dua Puluh';
        TensText[3] := 'Tiga Puluh';
        TensText[4] := 'Empat Puluh';
        TensText[5] := 'Lima Puluh';
        TensText[6] := 'Enam Puluh';
        TensText[7] := 'Tujuh Puluh';
        TensText[8] := 'Delapan Puluh';
        TensText[9] := 'Sembilan Puluh';
        TensText[10] := 'Seratus';

        ExponentText[1] := 'Ratus';
        ExponentText[2] := 'Ribu';
        ExponentText[3] := 'Juta';
        ExponentText[4] := 'Milyar';
    end;

    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        FindPos: Integer;
    begin
        FindPos := STRPOS(String, FindWhat);
        WHILE FindPos > 0 DO BEGIN
            NewString += DELSTR(String, FindPos) + ReplaceWith;
            String := COPYSTR(String, FindPos + STRLEN(FindWhat));
            FindPos := STRPOS(String, FindWhat);
        END;
        NewString += String;
    end;

    var
        GenJournalLine: Record "Gen. Journal Line";
        Currency: Record Currency;
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[4] of Text[30];


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"G/L Entry-Edit", 'OnBeforeGLLedgEntryModify', '', false, false)]
    local procedure OnBeforeGLLedgEntryModify_Ext(var GLEntry: Record "G/L Entry"; FromGLEntry: Record "G/L Entry")
    begin
        GLEntry.TypeAudit := FromGLEntry.TypeAudit;
    end;
}