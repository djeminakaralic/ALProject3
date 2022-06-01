report 50071 "Rad-1G"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Rad-1G.rdlc';

    dataset
    {
        dataitem(SF1; integer)
        {
            MaxIteration = 1;
            column(UkupnoFeb; output[1] [1])
            {
            }
            column(ZeneFeb; output[1] [2])
            {
            }
            column(UkupnoDosli; output[2] [1])
            {
            }
            column(ZeneDosli; output[2] [2])
            {
            }
            column(UkupnoOtisli; output[3] [1])
            {
            }
            column(ZeneOtisli; output[3] [2])
            {
            }
            column(UkupnoMart; output[4] [1])
            {
            }
            column(ZeneMart; output[4] [2])
            {
            }
            column(NazivKomp; CompInfo.Name)
            {
            }
            column(JIB; CompInfo."Registration No.")
            {
            }
            column(OrgID; OrgID)
            {
            }
            column(OrgName; OrgName)
            {
            }
            column(OrgAddress; OrgAddress)
            {
            }
            column(OrgTelephone; OrgTelephone)
            {
            }
            column(OrgJIB; OrgJIB)
            {
            }
            column(OrgJIBName; OrgJIBName)
            {
            }
            column(Telefon; Telefon)
            {
            }
            column(emaill; emaill)
            {
            }
            column(AdresaKomp; CompInfo.Address)
            {
            }
            column(TelefonKomp; CompInfo."Phone No.")
            {
            }
            column(DjelatnostKomp; CompInfo."Industrial Classification")
            {
            }
            column(KompKanton; Kanton)
            {
            }
            column(KompOpcina; Opcina)
            {
            }
            column(LastDateOfMonth; LastDateOfMonth)
            {
            }
            column(DayBeforeFirstDate; DayBeforeFirstDate)
            {
            }
            column(Monthlbl; Monthlbl)
            {
            }

            trigger OnAfterGetRecord()
            begin


                CompInfo.GET;
                BROJAC := BROJAC + 1;


                Org.SETFILTER("Municipality Code", '%1', Municipality);
                Org.SETFILTER(Description, '%1', OrgJed);
                Org.SETFILTER(Active, '%1', TRUE);
                IF Org.FINDFIRST THEN BEGIN
                    OrgName := Org.Description;
                    OrgID := Org."ORG ID";
                    OrgAddress := Org.Address;
                    OrgTelephone := Org.Telephone;
                    OrgJIB := Org."Industrial Classification";
                    OrgJIBName := Org."Industrial Classification Name";
                END;

                IF OrgID = '' THEN
                    OrgID := '                                  ';
                IF OrgJIB = '' THEN
                    OrgJIB := '      ';

                CompMunicipality.SETFILTER(Code, '%1', Municipality);
                IF CompMunicipality.FINDFIRST THEN BEGIN
                    Opcina := CompMunicipality.Name;
                    PostCode.SETFILTER(City, '%1', CompMunicipality.City);
                    IF PostCode.FINDFIRST THEN BEGIN
                        CompCanton.SETFILTER(Code, '%1', PostCode."Canton Code");
                        IF CompCanton.FINDFIRST THEN BEGIN
                            Kanton := CompCanton.Description;
                        END;
                    END;
                END;

                UserPer.RESET;
                UserPer.SETFILTER("User Name", '%1', USERID);
                IF UserPer.FINDFIRST THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', UserPer."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        Telefon := Empppp."Company Phone No.";
                        emaill := Empppp."Company E-Mail";
                        Dateof := TODAY;
                    END;


                END;


                f1;
            end;

            trigger OnPreDataItem()
            begin
                Start2 := Fill.GetMonthRange(Month, Year, TRUE);
                End2 := Fill.GetMonthRange(Month, Year, FALSE);
            end;
        }
        dataitem(SF2; integer)
        {
            MaxIteration = 1;
            column(Neodr; output[5] [1])
            {
            }
            column(ZeneNeodr; output[5] [2])
            {
            }
            column(Odr; output[6] [1])
            {
            }
            column(ZeneOdr; output[6] [2])
            {
            }
            column(PripravniciUk; output[7] [1])
            {
            }
            column(PripravniciZene; output[7] [2])
            {
            }

            trigger OnAfterGetRecord()
            begin
                f2;
            end;
        }
        dataitem(SF3; integer)
        {
            MaxIteration = 1;
            column(PunoRadnoVr; output[8] [1])
            {
            }
            column(PunoRadnoVrZene; output[8] [2])
            {
            }
            column(NepRadnVr; output[9] [1])
            {
            }
            column(NepRadnVrZene; output[9] [2])
            {
            }
        }
        dataitem(SF7; integer)
        {
            MaxIteration = 1;
            column(VSS; output[10] [1])
            {
            }
            column(VSSZene; output[10] [2])
            {
            }
            column("VŠS"; output[11] [1])
            {
            }
            column("VŠSZene"; output[11] [2])
            {
            }
            column(SSS; output[12] [1])
            {
            }
            column(SSSZene; output[12] [2])
            {
            }
            column(NizeStrucno; output[13] [1])
            {
            }
            column(NizeStrucnoZene; output[13] [2])
            {
            }
            column(VKV; output[14] [1])
            {
            }
            column(VKVZene; output[14] [2])
            {
            }
            column(KV; output[15] [1])
            {
            }
            column(KVZene; output[15] [2])
            {
            }
            column(PK; output[16] [1])
            {
            }
            column(PKZene; output[16] [2])
            {
            }
            column(NK; output[17] [1])
            {
            }
            column(NKZene; output[17] [2])
            {
            }
            column(DR; output[18] [1])
            {
            }
            column(DRZene; output[18] [2])
            {
            }
            column(MR; output[19] [1])
            {
            }
            column(MRZene; output[19] [2])
            {
            }
        }
        dataitem(SF7a; integer)
        {
            MaxIteration = 1;
            column(Do18; output[20] [1])
            {
            }
            column(Do18Zene; output[20] [2])
            {
            }
            column(Od19Do24; output[21] [1])
            {
            }
            column(Od19Do24Zene; output[21] [2])
            {
            }
            column(Od25Do29; output[22] [1])
            {
            }
            column(Od25Do29DoZene; output[22] [2])
            {
            }
            column(Od30Do34; output[23] [1])
            {
            }
            column(Od30Do34Zene; output[23] [2])
            {
            }
            column(Od35Do39; output[24] [1])
            {
            }
            column(Od35Do39Zene; output[24] [2])
            {
            }
            column(Od40Do44; output[25] [1])
            {
            }
            column(Od40Do44Zene; output[25] [2])
            {
            }
            column(Od45Do49; output[26] [1])
            {
            }
            column(Od45Do49Zene; output[26] [2])
            {
            }
            column(Od50Do54; output[27] [1])
            {
            }
            column(Od50Do54Zene; output[27] [2])
            {
            }
            column(Od55Do59; output[28] [1])
            {
            }
            column(Od55Do59Zene; output[28] [2])
            {
            }
            column(Od60Do64; output[29] [1])
            {
            }
            column(Od60Do64Zene; output[29] [2])
            {
            }
            column(Od65Vise; output[30] [1])
            {
            }
            column(Od65ViseZene; output[30] [2])
            {
            }
        }
        dataitem(SF8; integer)
        {
            MaxIteration = 1;
            column(ManjeOd160; output[31] [1])
            {
            }
            column(Do350; output[32] [1])
            {
            }
            column(Od351Do500; output[33] [1])
            {
            }
            column(Od501Do650; output[34] [1])
            {
            }
            column(Od651Do800; output[35] [1])
            {
            }
            column(Od801Do950; output[36] [1])
            {
            }
            column(Od951Do1100; output[37] [1])
            {
            }
            column(Od1101Do1400; output[38] [1])
            {
            }
            column(Od1401Do1700; output[39] [1])
            {
            }
            column(Od1701Do2000; output[40] [1])
            {
            }
            column(Od2001Do2500; output[41] [1])
            {
            }
            column(Od2501Do3000; output[42] [1])
            {
            }
            column(Preko3000; output[43] [1])
            {
            }
            column(Preko200; output[44] [1])
            {
            }
        }
        dataitem(SF8a; integer)
        {
            MaxIteration = 1;
            column(ZapZenePreth; output[45] [3])
            {
            }
            column(ZapMuskPreth; output[46] [3])
            {
            }
            column(VSSPrethodna; output[48] [3])
            {
            }
            column("VŠSPrethodna"; output[49] [3])
            {
            }
            column(SSSPrethodna; output[50] [3])
            {
            }
            column(NizaStrucnaPreth; output[51] [3])
            {
            }
            column(VKPrethodna; output[52] [3])
            {
            }
            column(KVPrethodna; output[53] [3])
            {
            }
            column(PKPrethodna; output[54] [3])
            {
            }
            column(NKPrethodna; output[55] [3])
            {
            }
            column(NetoPrethZene; output[45] [2])
            {
            }
            column(NetoPrethMuskarci; output[46] [2])
            {
            }
            column(NetoVSSPrethodna; output[48] [2])
            {
            }
            column("NetoVŠSPrethodna"; output[49] [2])
            {
            }
            column(NetoSSSPrethodna; output[50] [2])
            {
            }
            column(NetoNizaPrethodna; output[51] [2])
            {
            }
            column(NetoVKVPrethodna; output[52] [2])
            {
            }
            column(NetoKVPrethodna; output[53] [2])
            {
            }
            column(NetoPKPrethodna; output[54] [2])
            {
            }
            column(NetoNKPrethodna; output[55] [2])
            {
            }
            column(BrutoPrethZene; output[45] [1])
            {
            }
            column(BrutoPrethMuskarci; output[46] [1])
            {
            }
            column(BrutoVSSPrethodna; output[48] [1])
            {
            }
            column("BrutoVŠSPrethodna"; output[49] [1])
            {
            }
            column(BrutoSSSPrethodna; output[50] [1])
            {
            }
            column(BrutoNizaPrethodna; output[51] [1])
            {
            }
            column(BrutoVKVPrethodna; output[52] [1])
            {
            }
            column(BrutoKVPrethodna; output[53] [1])
            {
            }
            column(BrutoPKPrethodna; output[54] [1])
            {
            }
            column(BrutoNKPrethodna; output[55] [1])
            {
            }
            column(ProsjNetoPrethZene; output[45] [4])
            {
            }
            column(ProsjNetoPrethMuskarci; output[46] [4])
            {
            }
            column(ProsjNetoVSSPrethodna; output[48] [4])
            {
            }
            column("ProsjNetoVŠSPrethodna"; output[49] [4])
            {
            }
            column(ProsjNetoSSSPrethodna; output[50] [4])
            {
            }
            column(ProsjNetoNizaPrethodna; output[51] [4])
            {
            }
            column(ProsjNetoVKVPrethodna; output[52] [4])
            {
            }
            column(ProsjNetoKVPrethodna; output[53] [4])
            {
            }
            column(ProsjNetoPKPrethodna; output[54] [4])
            {
            }
            column(ProsjNetoNKPrethodna; output[55] [4])
            {
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Month; Month)
                    {
                        Caption = 'Month';
                    }
                    field(Year; Year)
                    {
                        Caption = 'Year';
                    }
                    field(Municipality; Municipality)
                    {
                        Caption = 'Municipality';
                        TableRelation = Municipality;
                    }
                    field(OrgJed; OrgJed)
                    {
                        Caption = 'Org Jed';
                        TableRelation = "ORG Dijelovi".Description WHERE(Active = FILTER(true));
                    }
                    field(UpdateOrg; UpdateOrg)
                    {
                        Caption = 'UpdateOrg';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FirstDateOfMonth := DMY2DATE(1, Month, Year);
        LastDateOfMonth := CALCDATE('-1D', CALCDATE('+1M', FirstDateOfMonth));
        DayBeforeFirstDate := CALCDATE('-1D', FirstDateOfMonth);
        // MESSAGE(FORMAT(FirstDateOfMonth)+' ' +FORMAT(LastDateOfMonth)+' '+FORMAT(DayBeforeFirstDate));
        CASE Month OF
            1:
                Monthlbl := 'JANUAR';
            2:
                Monthlbl := 'FEBRUAR';
            3:
                Monthlbl := 'MART';
            4:
                Monthlbl := 'APRIL';
            5:
                Monthlbl := 'MAJ';
            6:
                Monthlbl := 'JUNI';
            7:
                Monthlbl := 'JULI';
            8:
                Monthlbl := 'AVGUST';
            9:
                Monthlbl := 'SEPTEMBAR';
            10:
                Monthlbl := 'OKTOBAR';
            11:
                Monthlbl := 'NOVEMBAR';
            12:
                Monthlbl := 'DECEMBAR';

        END;
        output[31] [1] := 0;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                IF EmployeeContractLedger."Ending Date" = 0D THEN
                    EmployeeContractLedger."Report Ending Date" := TODAY
                ELSE
                    EmployeeContractLedger."Report Ending Date" := EmployeeContractLedger."Ending Date";
                EmployeeContractLedger.MODIFY;

            UNTIL EmployeeContractLedger.NEXT = 0;
        EmployeeReal.RESET;
        EmployeeReal.SETFILTER(Header, '%1', TRUE);
        IF EmployeeReal.FINDSET THEN
            REPEAT
                EmployeeReal.Header := FALSE;
                EmployeeReal.MODIFY;
            UNTIL EmployeeReal.NEXT = 0;


        EmployeeReal.RESET;
        IF EmployeeReal.FINDSET THEN
            REPEAT
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmployeeReal."No.");
                EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', DMY2DATE(31, 12, Year - 1));
                EmployeeContractLedger.SETFILTER("Ending Date", '>=%1|%2', DMY2DATE(1, 1, Year - 1), 0D);
                IF Municipality <> '' THEN
                    EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                        ELSE
                            EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                    END;
                END;
                IF EmployeeContractLedger.FINDFIRST THEN BEGIN

                    EmployeeReal.Header := TRUE;
                    EmployeeReal.MODIFY;

                END;
            UNTIL EmployeeReal.NEXT = 0;


        IF UpdateOrg = TRUE THEN BEGIN
            WC.RESET;
            /*WC.SETFILTER("Org Jed",'%1','');
            WC.SETFILTER(Munif,'%1','');*/
            IF WC.FINDSET THEN
                REPEAT


                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', WC."Employee No.");
                    CloseDate := Fill.GetMonthRange(WC."Month Of Wage", WC."Year of Wage", FALSE);

                    FirstDatee := Fill.GetMonthRange(WC."Month Of Wage", WC."Year of Wage", TRUE);
                    ECL.SETFILTER("Starting Date", '<=%1', CloseDate);
                    ECL.SETFILTER("Ending Date", '>=%1|%2', FirstDatee, 0D);
                    ECL.SETCURRENTKEY("Starting Date");
                    ECL.ASCENDING;
                    IF ECL.FINDLAST THEN BEGIN
                        ECL.CALCFIELDS("Org Municipality of ag");
                        IF ECL."GF of work Description" <> '' THEN
                            WC."Org Jed" := ECL."GF of work Description"
                        ELSE
                            WC."Org Jed" := ECL."Org Unit Name";
                        WC.Munif := ECL."Org Municipality of ag";
                        WC.MODIFY;
                    END;

                UNTIL WC.NEXT = 0;
        END;

    end;

    var
        Month: Integer;
        Monthlbl: Text;
        EGT: Record "Engagement Type";
        Year: Integer;
        E: Record "Employee";
        output: array[55, 4] of Decimal;
        outputTemp: array[12, 12] of Decimal;
        BROJAC: Integer;
        OrgName: Text;
        CloseDate: Date;
        FirstDateOfMonth: Date;
        LastDateOfMonth: Date;
        DayBeforeFirstDate: Date;
        WH: Record "Wage Header";
        End2: Date;
        Start2: Date;
        EmployeeReal: Record "Employee";
        UpdateOrg: Boolean;
        Fill: Codeunit "Absence Fill";
        WC: Record "Wage Calculation";
        Telefon: Text;
        emaill: Text;
        FirstDatee: Date;
        Dateof: Date;
        i: Integer;
        j: Integer;
        k: Integer;
        WCNew: Record "Wage Calculation";
        Nerade: Decimal;
        BrojPlacenihManje: Decimal;
        z: Integer;
        KorekcijaNerade: Decimal;
        IZnossss: Decimal;
        Value1: Decimal;
        Value2: Decimal;
        UserPer: Record "User Setup";
        NeplaceniNeRade: Decimal;
        CompInfo: Record "Company Information";
        Kanton: Text;
        Opcina: Text;
        CompCounty: Record "Canton";
        Wveeee: Record "Wage Value Entry";
        CompCanton: Record "Canton";
        CompMunicipality: Record "Municipality";
        sumaTemp1: Decimal;
        sumaTemp2: Decimal;
        Position: Record "Position";
        Municipality: Code[10];
        Org: Record "ORG Dijelovi";
        OrgID: Text;
        OrgAddress: Text;
        OrgTelephone: Text;
        OrgJIB: Text;
        OrgJIBName: Text;
        PostCode: Record "Post Code";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        ECL: Record "Employee Contract Ledger";
        OrgJed: Text;
        ECL2: Record "Employee Contract Ledger";
        NemajuUg: Integer;
        NemajuUgZene: Integer;
        Empppp: Record "Employee";
        Sumaaa: Integer;
        SumaaaaaaZene: Integer;
        Neaktivni: Integer;
        Neaktivnizene: Integer;
        AdditionalEducation: Record "Additional Education";
        Godineee: Integer;
        rEZ: Decimal;
        SumaKorekcija: Decimal;
        sumaTemp5: Decimal;
        WaddAdd: Record "Wage Addition";
        Neplaceni: Decimal;
        COA: Record "Cause of Absence";
        BrojPlacenih: Integer;
        EmpAbs: Record "Employee Absence";
        SumaBrutto: Decimal;
        SumaNetto: Decimal;
        Brojacx: Integer;
        Brojacy: Integer;
        BrojLjudi: Integer;
        Dates: array[12] of Date;
        BrojMjeseci: Integer;
        AbsenceFill: Codeunit "Absence Fill";
        WageAddition: Record "Wage Addition";
        WageType: Record "Wage Addition Type";
        DodatnoBruto: Decimal;
        DodatnoNeto: Decimal;

    procedure f1()
    var
        ETemp: Record "Employee" temporary;
        ETemp1: Record "Employee";
        ETemp5: Record "Employee";
    begin


        //DayBeforeFirstDate kao 30.4.2019
        //LastDateOfMonth 31.5.2019
        //FirstDateOfMonth 1.5.2019

        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', DayBeforeFirstDate);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', DayBeforeFirstDate);
        IF EmployeeContractLedger."Org Municipality of ag" <> '' THEN
            EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality)
        ELSE
            EmployeeContractLedger.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                //######################## 1
                WH.RESET;


                WH.SETRANGE("Month Of Wage", DATE2DMY(DayBeforeFirstDate, 2));
                WH.SETRANGE("Year Of Wage", DATE2DMY(DayBeforeFirstDate, 3));
                //WH.SETRANGE("Wage Calculation Type",WH."Wage Calculation Type"::Normal);

                IF WH.FIND('-') THEN BEGIN
                    WC.RESET;
                    WC.SETRANGE("Wage Header No.", WH."No.");
                    WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                    // WC.SETRANGE("Department Municipality",Municipality);
                    WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                    IF WC.FIND('-') THEN BEGIN
                        E.GET(WC."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := WC."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJed;

                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;
                    END
                END
                ELSE BEGIN
                    E.GET(EmployeeContractLedger."Employee No.");
                    IF EmployeeContractLedger."Engagement Type" <> 'EXTERNI ANGAZMAN' THEN BEGIN
                        ETemp.INIT;
                        ETemp."No." := EmployeeContractLedger."Employee No.";
                        i := 0;
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."E-Mail" := OrgJed;

                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;

                    END;
                END;

            UNTIL EmployeeContractLedger.NEXT = 0;


        //kraj posljednjeg mjeseca
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '>%1', 0D, DayBeforeFirstDate);
        ETemp.SETFILTER("Employment Date", '<%1', DayBeforeFirstDate);

        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER(Status, '%1|%2|%3', 0, 1, 2);
        IF ETemp.FINDFIRST THEN BEGIN
            output[1] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[1] [2] := ETemp.COUNT;
        END;
        //END;


        //######################## Ostalo
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Employment Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER(Gender, '<>%1', ETemp.Gender::" ");
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp.Gender := ETemp.Gender::" ";
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;




        //DOSLI DA JE ZAPOCELO U 8 MJESECU PRELAZ, ODNOSNO DA JE DATUM POCETKA MANJI OD 31.08.2018 ALI DA JE ISTO I DATUM POCETKA VECI OD 31.07.2018

        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1 & >%2', LastDateOfMonth, DayBeforeFirstDate);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', FirstDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);

        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");

                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '<=%1', LastDateOfMonth);
                ECL2.SETFILTER("Report Ending Date", '>=%1', FirstDateOfMonth);
                ECL2.SETCURRENTKEY("Starting Date");
                IF OrgJed = '' THEN
                    ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);
                ECL2.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            ECL2.SETFILTER("Org Unit Name", '<>%1', OrgJed)
                        ELSE
                            ECL2.SETFILTER("GF of work Description", '<>%1', OrgJed);
                        /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                          EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
                    END;
                END;
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    IF ECL2."Starting Date" < EmployeeContractLedger."Starting Date" THEN BEGIN
                        ECL2.CALCFIELDS("Org Municipality of ag");

                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", Month);
                        WH.SETRANGE("Year Of Wage", Year);
                        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);

                        IF WH.FIND('-') THEN BEGIN
                            WC.RESET;
                            WC.SETRANGE("Wage Header No.", WH."No.");
                            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                            WC.SETFILTER("Employee No.", '%1', ECL2."Employee No.");
                            IF WC.FIND('-') THEN BEGIN
                                E.GET(ECL2."Employee No.");
                                ETemp.INIT;
                                ETemp."No." := WC."Employee No.";
                                i := WC."Calculation Type";
                                ETemp."First Name" := FORMAT(i);
                                ETemp."Termination Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp."Employment Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp.Gender := E.Gender;
                                ETemp."Org Municipality" := Municipality;
                                ETemp."E-Mail" := OrgJed;

                                IF ETemp.INSERT THEN ETemp.MODIFY ELSE ETemp.MODIFY;
                            END;
                        END;
                    END;
                    // END;

                END;
            UNTIL EmployeeContractLedger.NEXT = 0;




        //########################
        NemajuUg := 0;
        NemajuUgZene := 0;
        ETemp.RESET;
        // ETemp.SETFILTER("Termination Date",'%1',0D,CALCDATE('<+1D>',Start2));
        ETemp.SETFILTER("Employment Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN
            output[2] [1] := ETemp.COUNT;
            //ETemp.SETRANGE(Gender, ETemp.Gender::Female);

        END;
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", Municipality);
        ETemp.SETFILTER(Gender, '%1', ETemp.Gender::Female);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN
            output[2] [2] := ETemp.COUNT;
        END;


        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '>=%1 & <=%2', FirstDateOfMonth, LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Reason for Change", '%1', EmployeeContractLedger."Reason for Change"::"New Contract");
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);

        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;

        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                NemajuUg := NemajuUg + 1;
                Empppp.RESET;
                Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");

                IF Empppp.FINDFIRST THEN BEGIN
                    IF Empppp.Gender = Empppp.Gender::Female THEN
                        NemajuUgZene := NemajuUgZene + 1;
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;

        output[2] [1] := output[2] [1] + NemajuUg;
        output[2] [2] := output[2] [2] + NemajuUgZene;



        //OTISLI TO JESTE U 8 MJESECU IMAJU RAZLICITE ORGANIZACIONE JEDINICE
        ETemp.RESET;
        ETemp.SETFILTER("Employment Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Employment Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;


        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', FirstDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN

                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;

        //MESSAGE(FORMAT(EmployeeContractLedger.COUNT));

        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '<=%1', LastDateOfMonth);
                ECL2.SETFILTER("Report Ending Date", '>=%1', FirstDateOfMonth);
                ECL2.SETCURRENTKEY("Starting Date");
                ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);
                ECL2.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN

                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            ECL2.SETFILTER("Org Unit Name", '%1', OrgJed)
                        ELSE
                            ECL2.SETFILTER("GF of work Description", '%1', OrgJed);
                        /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                          EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
                    END;
                END;


                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    IF EmployeeContractLedger."Starting Date" < ECL2."Starting Date" THEN BEGIN
                        ECL2.CALCFIELDS("Org Municipality of ag");
                        WH.RESET;
                        WH.SETRANGE("Month Of Wage", Month);
                        WH.SETRANGE("Year Of Wage", Year);
                        WH.SETRANGE("Wage Calculation Type", WH."Wage Calculation Type"::Normal);

                        IF WH.FIND('-') THEN BEGIN
                            WC.RESET;
                            WC.SETRANGE("Wage Header No.", WH."No.");
                            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                            WC.SETFILTER("Employee No.", '%1', ECL2."Employee No.");
                            // WC.SETRANGE("Department Municipality",Municipality);
                            IF WC.FIND('-') THEN BEGIN
                                E.GET(WC."Employee No.");
                                ETemp.INIT;
                                ETemp."No." := WC."Employee No.";
                                i := WC."Calculation Type";
                                ETemp."First Name" := FORMAT(i);
                                ETemp."Termination Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp."Employment Date" := CALCDATE('<+1D>', FirstDateOfMonth);
                                ETemp.Gender := E.Gender;
                                ETemp."Org Municipality" := Municipality;
                                ETemp."E-Mail" := OrgJed;
                                IF ETemp.INSERT
                                 THEN
                                    ETemp.MODIFY ELSE
                                    ETemp.MODIFY
                            END;
                        END;
                    END;
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;

        //######################## 3
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN
            output[3] [1] := ETemp.COUNT;
            //ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            //output[3][2] := ETemp.COUNT;

        END;


        /*Sumaaa:=0;
        SumaaaaaaZene:=0;
        EmployeeContractLedger.RESET;
        //SP
        //EmployeeContractLedger.SETFILTER("Starting Date",'<=%1',End2);
        //EmployeeContractLedger.SETFILTER("Report Ending Date",'>=%1',Start2);
       EmployeeContractLedger.SETFILTER("Report Ending Date",'%1',CALCDATE('<-1D>',FirstDateOfMonth));
       EmployeeContractLedger.CALCFIELDS("Org Municipality of ag");
       EmployeeContractLedger.SETFILTER("Org Municipality of ag",'%1',Municipality);
       //EmployeeContractLedger.CALCFIELDS("Org Municipality");
       //EmployeeContractLedger.SETFILTER("Org Municipality",'<>%1','');
        EmployeeContractLedger.SETFILTER("Show Record",'%1',TRUE);
         IF OrgJed <> '' THEN BEGIN
           Org.RESET;
           Org.SETFILTER(Description, '%1', OrgJed);
           Org.SETFILTER(Active, '%1', TRUE);
           IF Org.FINDFIRST THEN BEGIN

         IF Org."Branch Agency"=Org."Branch Agency"::Agency THEN
             ECL2.SETFILTER("Org Unit Name", '%1', OrgJed)
             ELSE
              ECL2.SETFILTER("GF of work Description", '%1', OrgJed);
              ECL2.CALCFIELDS("Org Municipality");
              ECL2.SETFILTER("Org Municipality",'<>%1','');

           {IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
             EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);}
           END;
             END;*/

        //MESSAGE(FORMAT(EmployeeContractLedger.COUNT));

        Sumaaa := 0;
        SumaaaaaaZene := 0;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Report Ending Date", '%1..%2', CALCDATE('<-1D>', FirstDateOfMonth), LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Grounds for Term. Description", '%1', '');
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed);
                IF Org."Branch Agency" = Org."Branch Agency"::Branch THEN
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);


        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT


                IF EmployeeContractLedger."Grounds for Term. Description" <> '' THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        IF Empppp.Gender = Empppp.Gender::Female THEN
                            SumaaaaaaZene := SumaaaaaaZene + 1;
                    END;
                    Sumaaa := Sumaaa + 1;

                END;
                ECL2.RESET;
                ECL2.SETFILTER("Starting Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);
                IF OrgJed = '' THEN
                    ECL2.SETFILTER("Org Municipality of ag", '<>%1', Municipality);
                ECL2.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                ECL2.SETFILTER("Show Record", '%1', TRUE);
                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN

                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            ECL2.SETFILTER("Org Unit Name", '<>%1', OrgJed)
                        ELSE
                            ECL2.SETFILTER("GF of work Description", '<>%1', OrgJed);
                        /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                          EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
                    END;
                END;

                //MESSAGE(FORMAT(Sumaaa));
                //Sumaaa:=0;
                ECL2.ASCENDING;
                IF ECL2.FINDFIRST THEN BEGIN
                    Empppp.RESET;
                    Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                    IF Empppp.FINDFIRST THEN BEGIN
                        IF Empppp.Gender = Empppp.Gender::Female THEN
                            SumaaaaaaZene := SumaaaaaaZene + 1;
                        //MESSAGE(FORMAT(EmployeeContractLedger."Employee No."));
                    END;

                    Sumaaa := Sumaaa + 1;
                    // MESSAGE(Empppp."No.");
                END;
            UNTIL EmployeeContractLedger.NEXT = 0;
        output[3] [1] := output[3] [1] + Sumaaa;


        //######################## 3
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', FirstDateOfMonth));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        ETemp.SETFILTER(Gender, '%1', ETemp.Gender::Female);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN
            output[3] [2] := ETemp.COUNT;
        END;
        output[3] [2] := output[3] [2] + SumaaaaaaZene;

        Neaktivni := 0;
        Neaktivnizene := 0;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Ending Date", '<%1 & >=%2', LastDateOfMonth, CALCDATE('<-1D>', FirstDateOfMonth));
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        EmployeeContractLedger.SETFILTER("Grounds for Term. Description", '<>%1', '');
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN

                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;


        //DA PRONADE BILO KOJI KOJI JE O79 NPR
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                Neaktivni := Neaktivni + 1;
                Empppp.RESET;
                Empppp.SETFILTER("No.", '%1', EmployeeContractLedger."Employee No.");
                IF Empppp.FINDFIRST THEN BEGIN
                    IF Empppp.Gender = Empppp.Gender::Female THEN
                        Neaktivnizene := Neaktivnizene + 1;

                END;

            UNTIL EmployeeContractLedger.NEXT = 0;

        output[3] [1] := output[3] [1] + Neaktivni;
        output[3] [2] := output[3] [2] + Neaktivnizene;






        output[4] [1] := output[1] [1] + output[2] [1] - output[3] [1];
        output[4] [2] := output[1] [2] + output[2] [2] - output[3] [2];


    end;

    procedure f2()
    var
        ETemp: Record "Employee" temporary;
    begin
        FOR i := 1 TO 30 DO
            FOR j := 1 TO 2 DO
                output[i] [j] := 0;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '<>%1', 0D);
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Termination Date" := 0D;
                ETemp."Hours In Day" := 0;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;

        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', LastDateOfMonth);
        EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT
                //######################## 1
                WH.RESET;


                WH.SETRANGE("Month Of Wage", DATE2DMY(LastDateOfMonth, 2));
                WH.SETRANGE("Year Of Wage", DATE2DMY(LastDateOfMonth, 3));
                //WH.SETRANGE("Wage Calculation Type",WH."Wage Calculation Type"::Normal);

                IF WH.FIND('-') THEN BEGIN
                    WC.RESET;
                    WC.SETRANGE("Wage Header No.", WH."No.");
                    WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                    // WC.SETRANGE("Department Municipality",Municipality);
                    WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                    IF WC.FIND('-') THEN BEGIN
                        E.GET(WC."Employee No.");
                        ETemp.INIT;
                        ETemp."No." := WC."Employee No.";
                        i := WC."Calculation Type";
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Org Municipality" := Municipality;
                        ETemp."Hours In Day" := E."Hours In Day";
                        ETemp.Age := ROUND((LastDateOfMonth - E."Birth Date") / 365.2425, 1, '<');
                        AdditionalEducation.RESET;
                        AdditionalEducation.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        AdditionalEducation.SETFILTER("From Date", '<=%1', LastDateOfMonth);
                        AdditionalEducation.SETCURRENTKEY("From Date");
                        AdditionalEducation.ASCENDING;
                        IF AdditionalEducation.FINDLAST THEN
                            ETemp."Education Level" := AdditionalEducation."Education Level";

                        IF EmployeeContractLedger.Prentice = TRUE THEN
                            ETemp."Professional Examination Date" := EmployeeContractLedger."Testing Period Starting Date"

                        ELSE
                            ETemp."Professional Examination Date" := 0D;
                        IF EmployeeContractLedger.Prentice = TRUE THEN
                            ETemp."Probation Period End" := EmployeeContractLedger."Testing Period Ending Date"

                        ELSE
                            ETemp."Probation Period End" := 0D;


                        ETemp."E-Mail" := OrgJed;
                        ETemp.Address := EmployeeContractLedger."Engagement Type";
                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;
                    END
                END
                ELSE BEGIN
                    E.GET(EmployeeContractLedger."Employee No.");
                    IF EmployeeContractLedger."Engagement Type" <> 'EXTERNI ANGAZMAN' THEN BEGIN
                        ETemp.INIT;
                        ETemp."No." := EmployeeContractLedger."Employee No.";
                        i := 0;
                        ETemp."First Name" := FORMAT(i);
                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                        ETemp.Gender := E.Gender;
                        ETemp."Hours In Day" := E."Hours In Day";
                        ETemp."Org Municipality" := Municipality;
                        ETemp.Age := ROUND((LastDateOfMonth - E."Birth Date") / 365.2425, 1, '<');
                        ETemp."E-Mail" := OrgJed;
                        AdditionalEducation.RESET;
                        AdditionalEducation.SETFILTER("Employee No.", '%1', WC."Employee No.");
                        AdditionalEducation.SETFILTER("From Date", '<=%1', LastDateOfMonth);
                        AdditionalEducation.SETCURRENTKEY("From Date");
                        AdditionalEducation.ASCENDING;
                        IF AdditionalEducation.FINDLAST THEN
                            ETemp."Education Level" := AdditionalEducation."Education Level";

                        ETemp.Address := EmployeeContractLedger."Engagement Type";
                        IF EmployeeContractLedger.Prentice = TRUE THEN
                            ETemp."Professional Examination Date" := EmployeeContractLedger."Testing Period Starting Date"

                        ELSE
                            ETemp."Professional Examination Date" := 0D;
                        IF EmployeeContractLedger.Prentice = TRUE THEN
                            ETemp."Probation Period End" := EmployeeContractLedger."Testing Period Ending Date"

                        ELSE
                            ETemp."Probation Period End" := 0D;


                        IF ETemp.INSERT THEN
                            ETemp.MODIFY
                        ELSE
                            ETemp.MODIFY;

                    END;
                END;

            UNTIL EmployeeContractLedger.NEXT = 0;

        /* ETemp.RESET;
         ETemp.SETFILTER("Termination Date",'%1',CALCDATE('<+1D>',DayBeforeFirstDate));
         ETemp.SETFILTER("Org Municipality",'%1',Municipality);
         IF OrgJed<>'' THEN
         ETemp.SETFILTER("E-Mail",'%1',OrgJed);
         IF OrgJed<>'' THEN
         ETemp.SETFILTER("E-Mail",'%1',OrgJed);
         ETemp.SETFILTER(Address,'%1|%2','NEODREĐENO','NEODREĐENO PROBNI');
         IF ETemp.FINDFIRST THEN BEGIN
        output[5][1] := ETemp.COUNT;
        ETemp.SETRANGE(Gender, ETemp.Gender::Female);
        output[5][2] := ETemp.COUNT;
        END;
        
         ETemp.RESET;
         ETemp.SETFILTER("Termination Date",'%1',CALCDATE('<+1D>',DayBeforeFirstDate));
         ETemp.SETFILTER("Org Municipality",'%1',Municipality);
         IF OrgJed<>'' THEN
         ETemp.SETFILTER("E-Mail",'%1',OrgJed);
         ETemp.SETFILTER(Address,'%1|%2','ODREĐENO','ODREĐENO PROBNI');
         IF ETemp.FINDFIRST THEN BEGIN
        output[6][1] := ETemp.COUNT;
        ETemp.SETRANGE(Gender, ETemp.Gender::Female);
        output[6][2] := ETemp.COUNT;
        END;*/


        IF ETemp.FIND('-') THEN
            REPEAT

                //*** vrsta radnog odnosa ***
                ECL.RESET;
                ECL.SETFILTER("Employee No.", '%1', ETemp."No.");
                ECL.SETFILTER("Starting Date", '<=%1', DayBeforeFirstDate);
                ECL.SETFILTER("Report Ending Date", '>=%1', DayBeforeFirstDate);
                IF ECL."Org Municipality of ag" <> '' THEN
                    ECL.SETFILTER("Org Municipality of ag", '%1', Municipality)
                ELSE
                    ECL.SETFILTER("Org Municipality", '%1', Municipality);
                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            ECL.SETFILTER("Org Unit Name", '%1', OrgJed)
                        ELSE
                            ECL.SETFILTER("GF of work Description", '%1', OrgJed);
                        /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                          EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
                    END;
                END;

                IF ECL.FINDLAST THEN BEGIN

                    EGT.SETFILTER(Description, '%1', ECL."Engagement Type");
                    IF EGT.FINDFIRST THEN BEGIN
                        IF (EGT.Code = '1') OR (EGT.Code = '2') THEN BEGIN
                            output[5] [1] := output[5] [1] + 1;
                            IF ETemp.Gender = ETemp.Gender::Female THEN
                                output[5] [2] := output[5] [2] + 1;
                        END;

                        IF (EGT.Code = '4') OR (EGT.Code = '5') THEN BEGIN
                            output[6] [1] := output[6] [1] + 1;
                            IF ETemp.Gender = ETemp.Gender::Female THEN
                                output[6] [2] := output[6] [2] + 1;
                        END;

                    END;

                END;

            UNTIL ETemp.NEXT = 0;


        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        ETemp.SETFILTER("Professional Examination Date", '<>%1', 0D);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN

            output[7] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[7] [2] := ETemp.COUNT;

        END;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Hours In Day", '%1', 8);
        IF ETemp.FINDFIRST THEN BEGIN
            output[8] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[8] [2] := ETemp.COUNT;
        END;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Hours In Day", '<%1 & >%2', 8, 0);
        IF ETemp.FINDFIRST THEN BEGIN
            output[9] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
            output[9] [2] := ETemp.COUNT;
        END;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);

        FOR i := 1 TO 10 DO BEGIN
            ETemp.SETRANGE(Gender);
            CASE i OF
                1:
                    ETemp.SETFILTER("Education Level", '%1|%2|%3', 6, 7, 8);
                2:
                    ETemp.SETRANGE("Education Level", 5);
                3:
                    ETemp.SETRANGE("Education Level", 2);
                4:
                    ETemp.SETRANGE("Education Level", 1);
                5:
                    ETemp.SETRANGE("Education Level", 4);
                6:
                    ETemp.SETRANGE("Education Level", 3);
                7:
                    ETemp.SETRANGE("Education Level", 9);
                8:
                    ETemp.SETRANGE("Education Level", 10);
                9:
                    ETemp.SETRANGE("Education Level", 8);
                10:
                    ETemp.SETRANGE("Education Level", 7);
            //8 doktori 7 magistri
            END;
            output[i + 9] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, E.Gender::Female);
            output[i + 9] [2] := ETemp.COUNT;
        END;


        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);

        FOR i := 1 TO 11 DO BEGIN
            ETemp.SETRANGE(Gender);
            CASE i OF
                1:
                    ETemp.SETFILTER(Age, '<=%1', 18);
                2:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 19, 24);
                3:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 25, 29);
                4:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 30, 34);
                5:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 35, 39);
                6:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 40, 44);
                7:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 45, 49);
                8:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 50, 54);
                9:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 55, 59);
                10:
                    ETemp.SETFILTER(Age, '>=%1 & <=%2', 60, 64);
                11:
                    ETemp.SETFILTER(Age, '>%1', 65);
            END;
            output[i + 19] [1] := ETemp.COUNT;
            ETemp.SETRANGE(Gender, E.Gender::Female);
            output[i + 19] [2] := ETemp.COUNT;
        END;


        ETemp.RESET;
        IF ETemp.FINDSET THEN
            REPEAT
                ETemp."Years of Experience" := 0;
                ETemp."Tax Deduction Amount" := 0;
                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FIND('-') THEN
            REPEAT

                WC.RESET;
                WC.SETFILTER("Year of Wage", '%1', DATE2DMY(LastDateOfMonth, 3));
                WC.SETFILTER("Month Of Wage", '%1', DATE2DMY(LastDateOfMonth, 2));
                WC.SETFILTER("Employee No.", '%1', ETemp."No.");
                IF WC.FINDLAST THEN BEGIN
                    Neplaceni := 0;
                    sumaTemp5 := WC."Individual Hour Pool";
                    WaddAdd.RESET;
                    WaddAdd.SETFILTER("Employee No.", '%1', WC."Employee No.");
                    WaddAdd.SETFILTER("Wage Header No.", '%1', WC."Wage Header No.");
                    WaddAdd.SETFILTER("No. Of Hours", '<>%1', 0);
                    WaddAdd.SETFILTER("Wage Addition Type", '<>%1 & <>%2 & <>%3', '820', '821', '822');
                    IF WaddAdd.FINDFIRST THEN BEGIN
                        WaddAdd.CALCSUMS("No. Of Hours");
                        SumaKorekcija := WaddAdd."No. Of Hours";
                    END;

                    COA.RESET;
                    COA.SETFILTER("Unpaid days", '%1', TRUE);
                    IF COA.FINDSET THEN
                        REPEAT

                            EmpAbs.RESET;
                            EmpAbs.SETFILTER("Employee No.", '%1', ETemp."No.");
                            EmpAbs.SETFILTER("From Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);
                            EmpAbs.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                            IF EmpAbs.FINDFIRST THEN BEGIN
                                EmpAbs.CALCSUMS(Quantity);
                                Neplaceni := Neplaceni + EmpAbs.Quantity;

                            END;

                        UNTIL COA.NEXT = 0;
                END;
                BrojPlacenih := ROUND(sumaTemp5 + SumaKorekcija - Neplaceni, 1, '=');
                ETemp."Years of Experience" := BrojPlacenih;
                /* ETemp."Tax Deduction Amount":=WC."Net Wage After Tax"- (WC."Meal to pay")-
                -(WC.Tax*WC."Meal to pay"/WC."Net Wage");*/
                Wveeee.RESET;
                Wveeee.SETFILTER("Employee No.", '%1', WC."Employee No.");
                Wveeee.SETFILTER("Document No.", '%1', WC."Wage Header No.");
                Wveeee.SETFILTER("Entry Type", '%1|%2|%3', Wveeee."Entry Type"::"Net Wage", Wveeee."Entry Type"::"Work Experience", Wveeee."Entry Type"::Taxable);
                IF Wveeee.FINDFIRST THEN BEGIN
                    Wveeee.CALCSUMS("Cost Amount (Actual)");
                    ETemp."Tax Deduction Amount" := Wveeee."Cost Amount (Actual)";
                END

                ELSE BEGIN
                    ETemp."Tax Deduction Amount" := 0;
                END;


                ETemp.MODIFY;
            UNTIL ETemp.NEXT = 0;




        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Report Ending Date", '%1..%2', FirstDateOfMonth, CALCDATE('<-1D>', LastDateOfMonth));
        IF EmployeeContractLedger."Org Municipality of ag" <> '' THEN
            EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality)
        ELSE
            EmployeeContractLedger.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN BEGIN
            Org.RESET;
            Org.SETFILTER(Description, '%1', OrgJed);
            Org.SETFILTER(Active, '%1', TRUE);
            IF Org.FINDFIRST THEN BEGIN
                IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                    EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                ELSE
                    EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                /*IF Org."Branch Agency"=Org."Branch Agency"::Branch THEN
                  EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);*/
            END;
        END;
        EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
        //EmployeeContractLedger.SETFILTER("Grounds for Term. Code",'<>%1','');
        IF EmployeeContractLedger.FINDSET THEN
            REPEAT

                Nerade := 0;
                KorekcijaNerade := 0;
                NeplaceniNeRade := 0;
                BrojPlacenihManje := 0;
                WC.RESET;
                WC.SETFILTER("Year of Wage", '%1', DATE2DMY(LastDateOfMonth, 3));
                WC.SETFILTER("Month Of Wage", '%1', DATE2DMY(LastDateOfMonth, 2));
                WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                IF WC.FINDLAST THEN BEGIN

                    Nerade := WC."Individual Hour Pool";
                    WaddAdd.RESET;
                    WaddAdd.SETFILTER("Employee No.", '%1', WC."Employee No.");
                    WaddAdd.SETFILTER("Wage Header No.", '%1', WC."Wage Header No.");
                    WaddAdd.SETFILTER("No. Of Hours", '<>%1', 0);
                    WaddAdd.SETFILTER("Wage Addition Type", '<>%1 & <>%2 & <>%3', '820', '821', '822');
                    IF WaddAdd.FINDFIRST THEN BEGIN
                        WaddAdd.CALCSUMS("No. Of Hours");
                        KorekcijaNerade := WaddAdd."No. Of Hours";
                    END;

                    COA.RESET;
                    COA.SETFILTER("Unpaid days", '%1', TRUE);
                    IF COA.FINDSET THEN
                        REPEAT

                            EmpAbs.RESET;
                            EmpAbs.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                            EmpAbs.SETFILTER("From Date", '%1..%2', FirstDateOfMonth, LastDateOfMonth);
                            EmpAbs.SETFILTER("Cause of Absence Code", '%1', COA.Code);
                            IF EmpAbs.FINDFIRST THEN BEGIN
                                EmpAbs.CALCSUMS(Quantity);
                                NeplaceniNeRade := NeplaceniNeRade + EmpAbs.Quantity;
                            END;

                        UNTIL COA.NEXT = 0;
                END;

                BrojPlacenihManje := ROUND(Nerade + KorekcijaNerade - NeplaceniNeRade, 1, '=');


                //output[31][1]
                IF BrojPlacenihManje < 160 THEN
                    output[31] [1] := output[31] [1] + 1;

            UNTIL EmployeeContractLedger.NEXT = 0;





        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Years of Experience", '>%1', 160);
        ETemp.SETFILTER("Tax Deduction Amount", '<>%1', 0);
        FOR i := 1 TO 11 DO BEGIN
            CASE i OF
                1:
                    ETemp.SETFILTER("Tax Deduction Amount", '<%1 & >%2', 350, 0);
                2:
                    ETemp.SETRANGE("Tax Deduction Amount", 351, 500);
                3:
                    ETemp.SETRANGE("Tax Deduction Amount", 501, 650);
                4:
                    ETemp.SETRANGE("Tax Deduction Amount", 651, 800);
                5:
                    ETemp.SETRANGE("Tax Deduction Amount", 801, 950);
                6:
                    ETemp.SETRANGE("Tax Deduction Amount", 951, 1100);
                7:
                    ETemp.SETRANGE("Tax Deduction Amount", 1101, 1400);
                8:
                    ETemp.SETRANGE("Tax Deduction Amount", 1401, 1700);
                9:
                    ETemp.SETRANGE("Tax Deduction Amount", 1701, 2000);
                10:
                    ETemp.SETRANGE("Tax Deduction Amount", 2001, 2500);
                11:
                    ETemp.SETRANGE("Tax Deduction Amount", 2501, 3000);
                12:
                    ETemp.SETRANGE("Tax Deduction Amount", 3000);
            END;
            output[i + 31] [1] := ETemp.COUNT;
        END;
        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Years of Experience", '<>%1', 0);
        ETemp.SETFILTER("Tax Deduction Amount", '<>%1', 0);
        ETemp.SETFILTER("Tax Deduction Amount", '>%1', 3000);
        IF ETemp.FINDFIRST THEN
            output[43] [1] := ETemp.COUNT;


        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Years of Experience", '<%1 & >%2', 160, 0);
        IF ETemp.FINDFIRST THEN
            output[31] [1] := ETemp.COUNT;

        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        ETemp.SETFILTER("Years of Experience", '>%1', 200);
        IF ETemp.FINDFIRST THEN
            output[44] [1] := ETemp.COUNT;




        //GODIŠNJI BRUTO
        /*
        E.RESET;
        BrojLjudi:=0;
        //žene muškarci brutoo
         j:=0;
        
        
        ETemp.RESET;
          ETemp.SETFILTER("Termination Date",'%1',CALCDATE('<+1D>',DayBeforeFirstDate));
          ETemp.SETFILTER("Org Municipality",'%1',Municipality);
         IF OrgJed<>'' THEN
         ETemp.SETFILTER("E-Mail",'%1',OrgJed);
         IF ETemp.FINDSET THEN REPEAT
          SumaBrutto:=0;
         SumaNetto:=0;
        WC.RESET;
        WC.SETFILTER("Wage Calculation Type",'%1',WC."Wage Calculation Type"::Regular);
        WC.SETFILTER("Employee No.",'%1',ETemp."No.");
        IF WC.FINDSET THEN REPEAT
        SumaBrutto:=SumaBrutto+WC.Brutto;
        SumaNetto:=SumaNetto+WC."Net Wage After Tax";
        
         UNTIL WC.NEXT=0;
         ETemp."Transport Amount":=SumaBrutto;
         ETemp."Work Experience Percentage":=SumaNetto;
         ETemp.MODIFY;
          UNTIL ETemp.NEXT=0;
        
        
        
        
        
           FOR Brojacx := 1 TO 9 DO BEGIN
            FOR Brojacy:=1 TO 4 DO BEGIN
              CASE Brojacx OF
                1: ETemp.SETRANGE(Gender, ETemp.Gender::Female);
                2: ETemp.SETRANGE(Gender, ETemp.Gender::Male);
                3: ETemp.SETFILTER("Education Level", '%1|%2|%3|%4',7,8,9,10);
                4: ETemp.SETRANGE("Education Level", 6);
                5: ETemp.SETRANGE("Education Level", 4);
                6: ETemp.SETRANGE("Education Level", 3);
                7: ETemp.SETRANGE("Education Level", 5);
                8: ETemp.SETRANGE("Education Level", 15);
                9: ETemp.SETRANGE("Education Level", 2);
                10: ETemp.SETRANGE("Education Level", 1);
              END;
              IF Brojacy=1 THEN
                output[Brojacx+44][Brojacy] := SumaBrutto;
                IF Brojacy=2 THEN
                output[Brojacx+44][Brojacy] := SumaNetto;
                IF Brojacy=3 THEN
                output[Brojacx+44][Brojacy] := BrojLjudi;
                  IF Brojacy=4 THEN
                output[Brojacx+44][Brojacy] := SumaNetto/BrojLjudi;
        END;
          END;
        UNTIL ETemp.NEXT=0;
        
        */
        f8a;

    end;

    procedure f3()
    var
        ETemp: Record "Employee" temporary;
    begin
    end;

    procedure f7()
    var
        ETemp: Record "Employee" temporary;
    begin
    end;

    procedure f7a()
    var
        ETemp: Record "Employee" temporary;
    begin
    end;

    procedure f8()
    var
        ETemp: Record "Employee" temporary;
        ETemp2: Record "Employee" temporary;
        ETemp3: Record "Employee" temporary;
    begin
    end;

    procedure f8a()
    var
        ETemp: Record "Employee" temporary;
        ETemp2: Record "Employee" temporary;
        ETemp3: Record "Employee" temporary;
        ETemp4: Record "Employee" temporary;
        ETemp5: Record "Employee" temporary;
        ETemp6: Record "Employee" temporary;
        ETemp7: Record "Employee" temporary;
        ETemp8: Record "Employee" temporary;
        ETemp9: Record "Employee" temporary;
        ETempRem: Record "Employee" temporary;
    begin
        ETemp.DELETEALL;
        Value1 := 0;
        Value2 := 0;

        //ide kroz svaki mjesec ko je radio u prethodnoj godini
        FOR BrojMjeseci := 1 TO 12 DO BEGIN
            Dates[BrojMjeseci] := AbsenceFill.GetMonthRange(BrojMjeseci, Year - 1, FALSE);
        END;




        EmployeeReal.RESET;
        EmployeeReal.SETFILTER(Header, '%1', TRUE);
        IF EmployeeReal.FINDSET THEN
            REPEAT
                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', DMY2DATE(31, 12, Year - 1));
                EmployeeContractLedger.SETFILTER("Report Ending Date", '>=%1', DMY2DATE(1, 1, Year - 1));
                EmployeeContractLedger.SETFILTER("Org Municipality of ag", '%1', Municipality);
                IF OrgJed <> '' THEN BEGIN
                    Org.RESET;
                    Org.SETFILTER(Description, '%1', OrgJed);
                    Org.SETFILTER(Active, '%1', TRUE);
                    IF Org.FINDFIRST THEN BEGIN
                        IF Org."Branch Agency" = Org."Branch Agency"::Agency THEN
                            EmployeeContractLedger.SETFILTER("Org Unit Name", '%1', OrgJed)
                        ELSE
                            EmployeeContractLedger.SETFILTER("GF of work Description", '%1', OrgJed);
                    END;
                END;
                EmployeeContractLedger.SETFILTER("Show Record", '%1', TRUE);
                EmployeeContractLedger.SETFILTER("Employee No.", '%1', EmployeeReal."No.");
                IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                    //######################## 1
                    WH.RESET;

                    FOR BrojMjeseci := 1 TO 12 DO BEGIN

                        WH.SETRANGE("Month Of Wage", DATE2DMY(Dates[BrojMjeseci], 2));
                        WH.SETRANGE("Year Of Wage", DATE2DMY(Dates[BrojMjeseci], 3));
                        //WH.SETRANGE("Wage Calculation Type",WH."Wage Calculation Type"::Normal);

                        IF WH.FIND('-') THEN BEGIN
                            WC.RESET;
                            WC.SETRANGE("Wage Header No.", WH."No.");
                            WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                            // WC.SETRANGE("Department Municipality",Municipality);
                            WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                            IF WC.FIND('-') THEN BEGIN
                                E.GET(WC."Employee No.");
                                ETemp.INIT;
                                ETemp."No." := WC."Employee No.";
                                i := WC."Calculation Type";
                                ETemp."First Name" := FORMAT(i);
                                ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                                ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                                ETemp."Additional Tax" := ETemp."Additional Tax" + 1;
                                ETemp.Gender := E.Gender;
                                ETemp."Org Municipality" := Municipality;
                                ETemp."Hours In Day" := E."Hours In Day";
                                ETemp.Age := ROUND((LastDateOfMonth - E."Birth Date") / 365.2425, 1, '<');
                                AdditionalEducation.RESET;
                                AdditionalEducation.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                AdditionalEducation.SETFILTER("From Date", '<=%1', LastDateOfMonth);
                                AdditionalEducation.SETCURRENTKEY("From Date");
                                AdditionalEducation.ASCENDING;
                                IF AdditionalEducation.FINDLAST THEN
                                    ETemp."Education Level" := AdditionalEducation."Education Level";


                                ETemp."E-Mail" := OrgJed;
                                ETemp.Address := EmployeeContractLedger."Engagement Type";


                                Wveeee.RESET;
                                Wveeee.SETFILTER("Year of Wage", '%1', WC."Year of Wage");
                                Wveeee.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                Wveeee.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
                                Wveeee.SETFILTER("ECL Org", '%1', OrgJed);
                                Wveeee.SETFILTER("ECL Mun", '%1', Municipality);
                                Wveeee.SETFILTER("Entry Type", '%1|%2|%3', Wveeee."Entry Type"::"Net Wage", Wveeee."Entry Type"::Taxable, Wveeee."Entry Type"::"Work Experience");

                                IF Wveeee.FINDFIRST THEN BEGIN
                                    Wveeee.CALCSUMS("Cost Amount (Brutto)");
                                    Wveeee.CALCSUMS("Cost Amount (Actual)");
                                    ETemp."Transport Amount" := Wveeee."Cost Amount (Brutto)";
                                    ETemp."Work Experience Percentage" := Wveeee."Cost Amount (Actual)";
                                END;

                                WCNew.RESET;
                                WCNew.SETFILTER("Year of Wage", '%1', WC."Year of Wage");
                                WCNew.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                WCNew.SETFILTER(Munif, '%1', Municipality);
                                WCNew.SETFILTER("Org Jed", '%1', OrgJed);
                                IF WCNew.FINDFIRST THEN
                                    ETemp."Additional Tax" := WCNew.COUNT;

                                IF ETemp.INSERT THEN
                                    ETemp.MODIFY
                                ELSE
                                    ETemp.MODIFY;
                            END
                        END
                        ELSE BEGIN

                            IF EmployeeContractLedger."Engagement Type" <> 'EXTERNI ANGAZMAN' THEN BEGIN

                                WH.RESET;
                                E.GET(EmployeeContractLedger."Employee No.");

                                WH.SETRANGE("Month Of Wage", DATE2DMY(Dates[BrojMjeseci], 2));
                                WH.SETRANGE("Year Of Wage", DATE2DMY(Dates[BrojMjeseci], 3));
                                //WH.SETRANGE("Wage Calculation Type",WH."Wage Calculation Type"::Normal);

                                IF WH.FIND('-') THEN BEGIN
                                    WC.RESET;
                                    WC.SETRANGE("Wage Header No.", WH."No.");
                                    WC.SETRANGE("Wage Calculation Type", WC."Wage Calculation Type"::Regular);
                                    // WC.SETRANGE("Department Municipality",Municipality);
                                    WC.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");

                                    IF WC.FIND('-') THEN BEGIN


                                        ETemp.INIT;
                                        ETemp."No." := EmployeeContractLedger."Employee No.";
                                        i := 0;
                                        ETemp."First Name" := FORMAT(i);
                                        ETemp."Termination Date" := CALCDATE('<+1D>', DayBeforeFirstDate);
                                        ETemp."Employment Date" := CALCDATE('<-1D>', DayBeforeFirstDate);
                                        ETemp.Gender := E.Gender;

                                        ETemp."Hours In Day" := E."Hours In Day";
                                        ETemp."Additional Tax" := ETemp."Additional Tax" + 1;
                                        ETemp."Org Municipality" := Municipality;
                                        ETemp.Age := ROUND((LastDateOfMonth - E."Birth Date") / 365.2425, 1, '<');
                                        ETemp."E-Mail" := OrgJed;
                                        AdditionalEducation.RESET;
                                        AdditionalEducation.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Employee No.");
                                        AdditionalEducation.SETFILTER("From Date", '<=%1', LastDateOfMonth);
                                        AdditionalEducation.SETCURRENTKEY("From Date");
                                        AdditionalEducation.ASCENDING;
                                        IF AdditionalEducation.FINDLAST THEN
                                            ETemp."Education Level" := AdditionalEducation."Education Level";

                                        ETemp.Address := EmployeeContractLedger."Engagement Type";
                                        Wveeee.RESET;
                                        Wveeee.SETFILTER("Year of Wage", '%1', WC."Year of Wage");
                                        Wveeee.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                        Wveeee.SETFILTER("RAD-1 Wage Excluded", '%1', FALSE);
                                        Wveeee.SETFILTER("ECL Org", '%1', OrgJed);
                                        Wveeee.SETFILTER("ECL Mun", '%1', Municipality);
                                        Wveeee.SETFILTER("Entry Type", '%1|%2|%3', Wveeee."Entry Type"::"Net Wage", Wveeee."Entry Type"::Taxable, Wveeee."Entry Type"::"Work Experience");
                                        IF Wveeee.FINDFIRST THEN BEGIN
                                            Wveeee.CALCSUMS("Cost Amount (Brutto)");
                                            Wveeee.CALCSUMS("Cost Amount (Actual)");
                                            ETemp."Transport Amount" := Wveeee."Cost Amount (Brutto)";
                                            ETemp."Work Experience Percentage" := Wveeee."Cost Amount (Actual)";



                                        END;
                                        WCNew.RESET;
                                        WCNew.SETFILTER("Year of Wage", '%1', WC."Year of Wage");
                                        WCNew.SETFILTER("Employee No.", '%1', WC."Employee No.");
                                        WCNew.SETFILTER("Org Jed", '%1', OrgJed);
                                        WCNew.SETFILTER(Munif, '%1', Municipality);
                                        IF WCNew.FINDFIRST THEN
                                            ETemp."Additional Tax" := WCNew.COUNT;
                                        IF ETemp.INSERT THEN
                                            ETemp.MODIFY
                                        ELSE
                                            ETemp.MODIFY;
                                    END;
                                END;


                            END;
                        END;
                    END;
                END;
            UNTIL EmployeeReal.NEXT = 0;


        ETemp.RESET;
        ETemp.SETFILTER("Additional Tax", '<>%1', 0);
        IF ETemp.FINDSET THEN
            REPEAT
                WCNew.RESET;
                WCNew.SETFILTER("Year of Wage", '%1', Year - 1);
                WCNew.SETFILTER("Employee No.", '%1', ETemp."No.");
                WCNew.SETFILTER(Munif, '%1', Municipality);
                WCNew.SETFILTER("Org Jed", '%1', OrgJed);
                IF WCNew.FINDFIRST THEN BEGIN
                    ETemp."Additional Tax" := WCNew.COUNT;
                    ETemp.MODIFY;
                END;

            UNTIL ETemp.NEXT = 0;





        ETemp.RESET;
        ETemp.SETFILTER("Termination Date", '%1', CALCDATE('<+1D>', DayBeforeFirstDate));
        ETemp.SETFILTER("Org Municipality", '%1', Municipality);
        IF OrgJed <> '' THEN
            ETemp.SETFILTER("E-Mail", '%1', OrgJed);
        IF ETemp.FINDFIRST THEN BEGIN
            FOR Brojacx := 1 TO 11 DO BEGIN
                FOR Brojacy := 1 TO 4 DO BEGIN
                    CASE Brojacx OF
                        1:
                            ETemp.SETRANGE(Gender, ETemp.Gender::Female);
                        2:
                            ETemp.SETRANGE(Gender, ETemp.Gender::Male);
                        3:
                            ETemp.SETFILTER(Gender, '%1|%2', ETemp.Gender::Female, ETemp.Gender::Male);
                        4:
                            ETemp.SETFILTER("Education Level", '%1|%2|%3', 6, 7, 8);
                        5:
                            ETemp.SETRANGE("Education Level", 5);
                        6:
                            ETemp.SETRANGE("Education Level", 2);
                        7:
                            ETemp.SETRANGE("Education Level", 1);
                        8:
                            ETemp.SETRANGE("Education Level", 4);
                        9:
                            ETemp.SETRANGE("Education Level", 3);
                        10:
                            ETemp.SETRANGE("Education Level", 9);
                        11:
                            ETemp.SETRANGE("Education Level", 10);
                    END;


                    IF Brojacy = 1 THEN BEGIN
                        //bruto
                        ETemp.CALCSUMS("Transport Amount");
                        //BRUTO
                        output[Brojacx + 44] [Brojacy] := ROUND(ETemp."Transport Amount", 1, '=');

                    END;
                    IF Brojacy = 2 THEN BEGIN
                        //neto
                        ETemp.CALCSUMS("Work Experience Percentage");
                        output[Brojacx + 44] [Brojacy] := ROUND(ETemp."Work Experience Percentage", 1, '=');
                    END;
                    IF Brojacy = 3 THEN BEGIN
                        ETemp.CALCSUMS("Additional Tax");
                        output[Brojacx + 44] [Brojacy] := ETemp."Additional Tax" / 12;
                    END;
                    IF Brojacy = 4 THEN BEGIN
                        ETemp.CALCSUMS("Additional Tax");
                        IF ETemp."Additional Tax" <> 0 THEN BEGIN
                            output[Brojacx + 44] [Brojacy] := ETemp."Work Experience Percentage" / (ETemp."Additional Tax" / 12);
                        END
                        ELSE BEGIN
                            output[Brojacx + 44] [Brojacy] := 0;
                        END;
                    END;


                END;
            END;
        END;
        //END;
    end;
}

