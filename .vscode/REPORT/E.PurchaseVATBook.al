report 50032 "Electronic Purchase VAT Book"
{
    DefaultLayout = RDLC;
    //ĐK   RDLCLayout = './KUF.rdlc';
    Caption = 'Electronic Purchase VAT Book';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST(Purchase));
            RequestFilterFields = "VAT Date";
            dataitem(DataItem2; "Detailed VAT Entry")
            {
                DataItemLink = "VAT Entry No." = FIELD("Entry No."),
                               Type = FIELD(Type);
                DataItemTableView = SORTING("VAT Entry No.")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    c0 := 0;
                    /*IF
                      (Column1 = 0) AND
                      (Column2 = 0) AND
                      (Column3 = 0) AND
                      (Column4 = 0) AND
                      (Column5 = 0) AND
                      (Column6 = 0)
                    THEN*/
                    //CurrReport.SKIP;
                    Total1 := Total1 + Column1;
                    Total2 := Total2 + Column2;
                    Total3 := Total3 + Column3;
                    Total4 := Total4 + Column4;
                    Total5 := Total5 + Column5;
                    Total6 := Total6 + Column6;
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column1)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column2)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column3)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column4)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column5)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column6)) + ';');
                    ve10.RESET;
                    ve10.SETRANGE("VAT Date", StartDate, EndDate);
                    ve10.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve10.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve10.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve10.SETFILTER("Document No.", '%1', "DataItem1"."Document No.");
                    ve10.SETFILTER(Type, '%1', ve10.Type::Purchase);
                    IF ve10.FIND('-')
                     THEN
                        REPEAT
                            c0 := c0 + ve10.Amount;
                        UNTIL ve10.NEXT = 0;
                    ve11.RESET;
                    ve11.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve11.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV MANJAK');
                    ve11.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve11.SETFILTER(Type, '%1', ve11.Type::Purchase);
                    IF ve11.FIND('-')
                     THEN
                        REPEAT
                            c1 := c1 + ABS(ve11.Amount);
                        UNTIL ve11.NEXT = 0;

                    ve12.RESET;
                    ve12.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve12.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve12.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve12.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve12.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve12.SETFILTER(Type, '%1', ve12.Type::Purchase);
                    IF ve12.FIND('-')
                     THEN
                        REPEAT
                            c2 := c2 + ve12."VAT Amount (retro.)";
                        UNTIL ve12.NEXT = 0;

                    ve17.RESET;
                    ve17.SETRANGE("VAT Date", StartDate, EndDate);
                    ve17.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve17.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve17.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve17.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve17.SETFILTER(Type, '%1', ve17.Type::Purchase);
                    IF ve17.FIND('-')
                     THEN
                        REPEAT
                            c8 := c8 + ve17.Amount;
                        UNTIL ve17.NEXT = 0;

                    ve19.RESET;
                    ve19.SETRANGE("VAT Date", StartDate, EndDate);
                    //NK ve19.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve19.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve19.SETFILTER(Type, '%1', ve19.Type::Purchase);
                    ve19.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve19.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve19.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve19.FIND('-')
                     THEN
                        REPEAT
                            fullvat2 := fullvat2 + ve19."VAT Amount (retro.)";
                        UNTIL ve19.NEXT = 0;


                    ve24.RESET;
                    ve24.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve24.SETFILTER("VAT Prod. Posting Group", '%1', 'SAMO PDV');
                    ve24.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve24.SETFILTER(Type, '%1', ve24.Type::Purchase);
                    IF ve24.FIND('-')
                     THEN
                        REPEAT
                            c20 := c20 + ABS(ve24.Amount);
                        UNTIL ve24.NEXT = 0;

                    //ROUND(c0+c1+c2+c8+fullvat2+c20,1,'<');


                    OutStreamObj.WRITETEXT(FORMAT(ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 1, '<')) + ';');

                    //rs:=ROUND(c3+c4+c7+fullvat2rs,1,'<');


                    ve13.RESET;
                    ve13.SETRANGE("VAT Date", StartDate, EndDate);
                    ve13.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve13.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve13.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve13.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve13.SETFILTER(Type, '%1', ve13.Type::Purchase);
                    IF ve13.FIND('-')
                     THEN
                        REPEAT
                            c3 := c3 + ve13.Amount;
                        UNTIL ve13.NEXT = 0;


                    ve14.RESET;
                    ve14.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve14.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve14.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve14.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve14.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve12.SETFILTER(Type, '%1', ve11.Type::Purchase);
                    IF ve14.FIND('-')
                     THEN
                        REPEAT
                            c4 := c4 + ve14."VAT Amount (retro.)";
                        UNTIL ve14.NEXT = 0;
                    ve20.RESET;
                    ve20.SETRANGE("VAT Date", StartDate, EndDate);
                    ve20.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve20.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve20.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve20.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve20.SETFILTER(Type, '%1', ve20.Type::Purchase);
                    IF ve20.FIND('-')

                    THEN
                        REPEAT
                            c7 := c7 + ve20.Amount;
                        UNTIL ve20.NEXT = 0;

                    ve21.RESET;
                    ve21.SETRANGE("VAT Date", StartDate, EndDate);
                    ve21.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve21.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve21.SETFILTER(Type, '%1', ve21.Type::Purchase);
                    ve21.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve21.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve21.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve21.FIND('-')
                     THEN
                        REPEAT
                            fullvat2rs := fullvat2rs + ve21."VAT Amount (retro.)";
                        UNTIL ve21.NEXT = 0;



                    OutStreamObj.WRITETEXT(FORMAT(ROUND(c3 + c4 + c7 + fullvat2rs, 1, '<')) + ';');

                    //db:=ROUND(c5+c6+c9+fullvat2db,1,'<');

                    ve15.RESET;
                    ve15.SETRANGE("VAT Date", StartDate, EndDate);
                    ve15.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve15.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve15.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve15.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve15.SETFILTER(Type, '%1', ve15.Type::Purchase);
                    IF ve15.FIND('-')
                     THEN
                        REPEAT
                            c5 := c5 + ve15.Amount;
                        UNTIL ve15.NEXT = 0;


                    ve16.RESET;
                    ve16.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve16.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve16.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve16.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve16.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    //ve12.SETFILTER(Type,'%1',ve11.Type::Sale);
                    IF ve16.FIND('-')
                     THEN
                        REPEAT
                            c6 := c6 + ve16."VAT Amount (retro.)";
                        UNTIL ve16.NEXT = 0;

                    ve23.RESET;
                    ve23.SETRANGE("VAT Date", StartDate, EndDate);
                    ve23.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve23.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve23.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve23.SETFILTER("Document No.", '%1', DataItem1."Document No.");

                    ve23.SETFILTER(Type, '%1', ve23.Type::Purchase);
                    IF ve23.FIND('-')

                    THEN
                        REPEAT
                            c9 := c9 + ve23.Amount;
                        UNTIL ve23.NEXT = 0;
                    ve22.RESET;
                    ve22.SETRANGE("VAT Date", StartDate, EndDate);
                    ve22.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve22.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve22.SETFILTER(Type, '%1', ve22.Type::Purchase);
                    ve22.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve22.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve22.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    IF ve22.FIND('-')
                     THEN
                        REPEAT
                            fullvat2db := fullvat2db + ve22."VAT Amount (retro.)";
                        UNTIL ve22.NEXT = 0;



                    OutStreamObj.WRITETEXT(FORMAT(ROUND(c5 + c6 + c9 + fullvat2db, 1, '<')) + ';');

                    Total7 := Total7 + ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 1, '<');
                    Total8 := Total8 + ROUND(c3 + c4 + c7 + fullvat2rs, 1, '<');
                    Total9 := Total9 + ROUND(c5 + c6 + c9 + fullvat2db, 1, '<');



                    OutStreamObj.WRITETEXT();
                    BrojRedova := BrojRedova + 1;



                    CALCFIELDS("Amount retro");

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompIn.GET;
                Brojac := Brojac + 1;

                OutStreamObj.WRITETEXT('2;');
                OutStreamObj.WRITETEXT(PorezniPeriod);
                OutStreamObj.WRITETEXT(';');
                OutStreamObj.WRITETEXT(FORMAT(Brojac));
                OutStreamObj.WRITETEXT(';');

                //tip dokumenta
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                    IF VendorLedgerEntry.Prepayment = TRUE THEN BEGIN
                        //avansi

                        TipDokumenta := '03';

                    END
                    ELSE BEGIN



                        IF (STRPOS(DataItem1."Gen. Bus. Posting Group", 'DOMAĆI') <> 0) AND (DataItem1.Import = FALSE) THEN BEGIN


                            TipDokumenta := '01';

                        END
                        ELSE BEGIN

                            IF (STRPOS(DataItem1."Gen. Bus. Posting Group", 'DOMAĆI') = 0) AND (DataItem1.Import = TRUE) THEN BEGIN


                                TipDokumenta := '04';

                            END
                            ELSE BEGIN


                                Vendorr.RESET;
                                Vendorr.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    IF Vendor."VAT Registration No." = CompIn."Registration No." THEN BEGIN

                                        TipDokumenta := '02';

                                    END
                                    ELSE BEGIN

                                        TipDokumenta := '05';

                                    END;

                                END;
                            END;
                        END;
                    END;
                END;

                OutStreamObj.WRITETEXT(TipDokumenta);
                OutStreamObj.WRITETEXT(';');

                IF (TipDokumenta = '01') OR (TipDokumenta = '02') OR (TipDokumenta = '03') THEN BEGIN
                    OutStreamObj.WRITETEXT(DataItem1."Document No." + ';');
                END
                ELSE BEGIN
                    IF (TipDokumenta = '04') OR ((TipDokumenta = '05')) THEN
                        OutStreamObj.WRITETEXT(DataItem1."External Document No." + ';');
                END;



                //OutStreamObj.WRITETEXT(DataItem1."Document No."+';');
                OutStreamObj.WRITETEXT(FORMAT(DataItem1."VAT Date", 10, '<Year4>-<Month,2>-<Day,2>') + ';');
                OutStreamObj.WRITETEXT(FORMAT(DataItem1."Posting Date", 10, '<Year4>-<Month,2>-<Day,2>') + ';');


                Vendor.RESET;
                Vendor.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                IF Vendor.FINDFIRST THEN BEGIN
                    OutStreamObj.WRITETEXT(Vendor.Name + ';');
                    OutStreamObj.WRITETEXT(Vendor.Address + ';');

                    IF (TipDokumenta = '04') THEN BEGIN
                        OutStreamObj.WRITETEXT('000000000000' + ';');
                        OutStreamObj.WRITETEXT('0000000000000' + ';');


                    END

                    ELSE BEGIN


                        IF DataItem1."Gen. Bus. Posting Group" = 'D-0-PDV' THEN BEGIN
                            OutStreamObj.WRITETEXT('' + ';');
                            OutStreamObj.WRITETEXT('' + ';');

                        END
                        ELSE BEGIN
                            OutStreamObj.WRITETEXT(Vendor."Registration No." + ';');
                            OutStreamObj.WRITETEXT(Vendor."VAT Registration No." + ';');
                        END;
                    END;
                END
                ELSE BEGIN
                    OutStreamObj.WRITETEXT('' + ';');
                    OutStreamObj.WRITETEXT('' + ';');
                    OutStreamObj.WRITETEXT('' + ';');
                END;

                DetailedVATEntry.RESET;
                DetailedVATEntry.SETFILTER("VAT Entry No.", '%1', DataItem1."Entry No.");
                IF NOT DetailedVATEntry.FINDFIRST THEN BEGIN
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT();
                END;





                //yymm format poreznog perioda}
            end;

            trigger OnPostDataItem()
            begin
                OutStreamObj.WRITETEXT('3' + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total1)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total2)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total3)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total4)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total5)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total6)) + ';');




                OutStreamObj.WRITETEXT(FORMAT(Replace(Total7)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total8)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total9)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(BrojRedova + 1) + ';');

                FileDoc.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                PorezniPeriod := DataItem1.GETFILTER("VAT Date");

                IF PorezniPeriod = '' THEN
                    ERROR('Porezni period mora biti unesen');
                IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
                    PorezniPeriod2 := PorezniPeriod;
                    IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                        PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
                END
                ELSE BEGIN
                    PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);
                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);

                END;

            end;
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

    trigger OnInitReport()
    begin
        Zaglavlje := '';
        NewLine := 13;
        Brojac := 0;
        Total1 := 0;
        Total3 := 0;
        Total2 := 0;
        Total10 := 0;
        Total4 := 0;
        Total5 := 0;
        Total6 := 0;
        Total7 := 0;
        Total8 := 0;
        Total9 := 0;
        BrojRedova := 0;

        //32 - fbih vlastita potrošnja
        //33 - RS vlastita potrošnja
        //34 - Brčko - vlastita potrošnja
    end;

    trigger OnPostReport()
    begin
        //OutStreamObj.WRITETEXT('3'+';');
        FileManagement.DownloadToFile('\\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\' + '01.csv', '\\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\' + Comp."Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '01.csv');
    end;

    trigger OnPreReport()
    begin
        FileDoc.CREATE('\\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\' + '01.csv', TEXTENCODING::UTF8);
        FIleName := '\\INFODOM-PC1\Users\ajna.gazibegovic\Documents\KIF_KUF\' + '01.csv';

        FileDoc.CREATEOUTSTREAM(OutStreamObj);

        //vrsta sloga
        Zaglavlje := Zaglavlje + '1;';
        Comp.GET;

        //PDV broj obveznika koji podnosi datoteku
        Zaglavlje := Zaglavlje + Comp."Registration No." + ';';

        PorezniPeriod := DataItem1.GETFILTER("VAT Date");
        IF PorezniPeriod = '' THEN
            ERROR('Porezni period mora biti unesen');
        IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
            PorezniPeriod2 := PorezniPeriod;
            IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
            EVALUATE(StartDate, COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..')));

            //1.1.2019..31.12.2019


            PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod2)));



        END
        ELSE BEGIN
            PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
            PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            StartDate := 0D;
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod)));

        END;

        Zaglavlje := Zaglavlje + PorezniPeriod + ';';

        Zaglavlje := Zaglavlje + '1;';

        Zaglavlje := Zaglavlje + '01;';
        Datum2 := FORMAT(WORKDATE, 0, '<Day,2>.<Month,2>.<Year,4>');//11.03.2020
        //EVALUATE(Datum,Datum2);

        //Zaglavlje:=Zaglavlje+COPYSTR(Datum2,7,4)+'-'+COPYSTR(Datum2,4,2)+'-'+COPYSTR(Datum2,1,2)+';';
        Zaglavlje := Zaglavlje + FORMAT(WORKDATE, 10, '<Year4>-<Month,2>-<Day,2>') + ';';
        Zaglavlje := Zaglavlje + FORMAT(TIME);





        OutStreamObj.WRITETEXT(Zaglavlje);
        OutStreamObj.WRITETEXT();
        BrojRedova := BrojRedova + 1;
    end;

    var

        FileDoc: File;
        FIleName: Text;
        Zaglavlje: Text;
        NewLine: Char;
        OutStreamObj: OutStream;
        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        Brojac: Integer;
        Comp: Record "Company Information";
        Datum: Date;
        Datum2: Text;
        Vendor: Record Vendor;
        Rezultat: Text;
        fullvat2db: Decimal;
        ve14: Record "VAT Entry";
        Res: Decimal;
        Total1: Decimal;
        ve20: Record "VAT Entry";
        c5: Decimal;
        c6: Decimal;
        ve15: Record "VAT Entry";
        ve23: Record "VAT Entry";
        ve22: Record "VAT Entry";
        ve13: Record "VAT Entry";
        ve16: Record "VAT Entry";
        DetailedVATEntry: Record "Detailed VAT Entry";
        c9: Decimal;
        ve21: Record "VAT Entry";
        Total2: Decimal;
        Total3: Decimal;
        Total4: Decimal;
        c3: Decimal;
        fullvat2rs: Decimal;
        c4: Decimal;
        c7: Decimal;
        Total5: Decimal;
        Total6: Decimal;
        Total7: Decimal;
        fullvat2: Decimal;
        Total8: Decimal;
        Total9: Decimal;
        Total10: Decimal;
        BrojRedova: Integer;
        FileManagement: Codeunit "File Management";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CompIn: Record "Company Information";
        Vendorr: Record Vendor;
        TipDokumenta: Text;
        ve10: Record "VAT Entry";
        StartDate: Date;
        EndDate: Date;
        c0: Decimal;
        ve11: Record "VAT Entry";
        c1: Decimal;
        ve12: Record "VAT Entry";
        c2: Decimal;
        ve17: Record "VAT Entry";
        c8: Decimal;
        ve19: Record "VAT Entry";
        ve24: Record "VAT Entry";
        c20: Decimal;

    procedure Replace(InsertValue: Decimal) ResultValue: Text
    begin
        Rezultat := FORMAT(InsertValue);
        //1.053,51
        Rezultat := DELCHR(Rezultat, '=', '.');
        Rezultat := CONVERTSTR(Rezultat, ',', '.');
        EXIT(Rezultat);
    end;
}

