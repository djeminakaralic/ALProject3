report 50102 "RBBH Export"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'RBBH Export';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Wage/Reduction Bank Accounts")
        {
            dataitem(DataItem1; "Payment Order")
            {


                column(RacunPrimaoca; RacunPrimaoca)
                {
                }
                column(MaticniBroj; MaticniBroj)
                {
                }
                column(Iznos; Iznos)
                {
                }

                trigger OnAfterGetRecord()
                begin

                    GenerateTextFile();


                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SETFILTER("Wage Header No.", '%1', ZaglavljePlate);
                    SETFILTER(Contributon, '%1', 'PLAĆA');
                    SETFILTER(RacunPrimaoca, '%1', DataItem2."Account No");

                    //     File1.CREATE('\\DJEMINA-KARALIC\Temp\Spisak_RAIFFEISEN.txt');
                    //   File1.CREATEOUTSTREAM(OutStreamObj);

                end;
            }

        }

    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Employee: Record "Employee";
        Brojac: Integer;
        MaticniBroj: Code[13];
        File1: File;
        OutStreamObj: OutStream;
        FirstString: Text;
        TempB: Codeunit "Temp Blob";
        Vrijednost: Text;
        IznosStvarni: Text;
        PayMentOrder: Record "Payment Order";
        IntegerValue: Integer;
        PayMentOrder2: Record "Payment Order";
        ZaglavljePlate: Code[20];
        BrojCifaraIznos: Integer;
        K: Integer;
        BrojNula: Integer;
        Decimal: Integer;
        NumberOfRecord: Integer;
        PayMentOrder3: Record "Payment Order";
        LastString: Text;
        NumberZero: Integer;
        Suma: Decimal;
        IntegerValueSuma: Integer;
        DecimalSuma: Integer;

    procedure SetParam(BrojZaglavljaPlate: Code[20])
    begin
        ZaglavljePlate := BrojZaglavljaPlate;
    end;

    procedure GenerateTextFile()
    var
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        Content_M: Text;
    begin
        FileName := 'Spisak Raiffeisen.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        Brojac := 0;


        PayMentOrder2.RESET;
        PayMentOrder2.CopyFilters(DataItem1);
        //PayMentOrder2.SETFILTER("Entry No.",'%1',"Entry No.");
        IF PayMentOrder2.FINDSET THEN
            REPEAT
                FirstString := '';
                Brojac := Brojac + 1;
                if StrLen(format(Brojac)) = 0 then
                    FirstString += '0000';
                if StrLen(format(Brojac)) = 1 then
                    FirstString += '000' + format(Brojac);
                if StrLen(format(Brojac)) = 2 then
                    FirstString += '00' + format(Brojac);
                if StrLen(format(Brojac)) = 3 then
                    FirstString += '0' + format(Brojac);
                if StrLen(format(Brojac)) > 3 then
                    FirstString += format(Brojac);
                FirstString += '	';

                FirstString += PayMentOrder2.RacunPrimaoca;
                FirstString += '   	';
                Employee.Reset();
                Employee.SetFilter("No.", '%1', PayMentOrder2.SvrhaDoznake3);
                if Employee.FindFirst() then begin
                    FirstString += UpperCase(Employee."Last Name");
                    FirstString += ' ';
                    FirstString += UpperCase(Employee."First Name")
                end;
                FirstString += '                         	      ';




                IF EVALUATE(PayMentOrder2.Iznos, FORMAT(ROUND(PayMentOrder2.Iznos, 1))) THEN
                    IntegerValue := PayMentOrder2.Iznos;
                BrojCifaraIznos := STRLEN(FORMAT(IntegerValue));
                BrojNula := 4 - BrojCifaraIznos;
                if BrojNula > 0 then begin
                    FOR K := 1 TO BrojNula DO BEGIN
                        FirstString += '0';
                    END;
                end;

                FirstString += FORMAT(IntegerValue);
                FirstString += '.';
                Decimal := PayMentOrder2.Iznos MOD IntegerValue;
                IF STRLEN(FORMAT(Decimal)) <> 2 THEN BEGIN
                    IF STRLEN(FORMAT(Decimal)) > 2 THEN BEGIN
                        FirstString += COPYSTR(FORMAT(Decimal), 1, 2);
                    END

                    ELSE BEGIN
                        FirstString += FORMAT(Decimal);
                        FirstString += '0';
                    END;
                END
                ELSE BEGIN
                    FirstString += FORMAT(Decimal);

                END;

                OutStr.WRITETEXT(FirstString);

                OutStr.WRITETEXT(); // This command is to move to next line

            UNTIL PayMentOrder2.NEXT = 0;

        TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        DownloadFromStream(Instr, '', '', '', FileName);



    end;
}

