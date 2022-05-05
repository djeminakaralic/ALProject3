xmlport 50001 "MIP 1023"
{

    Caption = 'MIP';
    DefaultNamespace = 'urn:PaketniUvozObrazaca_V1_0.xsd';
    Direction = Export;
    Encoding = UTF8;
    UseDefaultNamespace = true;

    schema
    {
        textelement("<paketniuvozobrasca>")
        {
            MaxOccurs = Once;
            TextType = BigText;
            XmlName = 'PaketniUvozObrazaca';
            Width = 45;
            tableelement(Table79; "Company Information")
            {
                MaxOccurs = Once;
                XmlName = 'PodaciOPoslodavcu';
                fieldelement(JIBPoslodavca; Table79."Registration No.")
                {
                }
                fieldelement(NazivPoslodavca; Table79.Name)
                {
                }
                textelement(BrojZahtjeva)
                {

                    trigger OnBeforePassVariable()
                    begin
                        BrojZahtjeva := '1';
                    end;
                }
                textelement(DatumPodnosenja)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterGetRecord()
                begin

                    DatumPodnosenjaT := FORMAT(TODAY);
                    DatumPodnosenja := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);
                    DatumUpisa := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);

                    IF EMPL.FIND('-') THEN
                        REPEAT
                            WC1.RESET;
                            WC1.SETRANGE("Employee No.", EMPL."No.");
                            WC1.SETRANGE("Month Of Wage", Month);
                            WC1.SETRANGE("Year of Wage", Year);
                            WC1.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');
                            WC1.SETRANGE("Wage Calculation Type", 0);
                            IF WC1.FIND('-') THEN
                                counter += 1;
                        UNTIL EMPL.NEXT = 0;
                    BrojUposlenih := FORMAT(counter);
                    //StartDateD:=DMY2DATE(1,IDMonth,IDYear);
                    //bt
                    //StartDateD:=DMY2DATE(1,XMLWageCalc."Month Of Wage",XMLWageCalc."Year Of Wage");

                    StartDateD := DMY2DATE(1, Month, Year);

                    EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                    JibJmb := Table79."Registration No.";
                    Naziv := Table79.Name;


                    PeriodOdT := FORMAT(StartDateD);
                    PeriodOd := '20' + COPYSTR(PeriodOdT, 7, 2) + '-' + COPYSTR(PeriodOdT, 4, 2) + '-' + COPYSTR(PeriodOdT, 1, 2);

                    PeriodDoT := FORMAT(EndDateD);
                    PeriodDo := '20' + COPYSTR(PeriodDoT, 7, 2) + '-' + COPYSTR(PeriodDoT, 4, 2) + '-' + COPYSTR(PeriodDoT, 1, 2);

                    SifraDjelatnosti := Table79."Industrial Classification";
                end;

                trigger OnPreXmlItem()
                begin

                    counter := 0;
                end;
            }
            textelement(Obrazac1023)
            {
                MaxOccurs = Once;
                textelement(Dio1)
                {
                    MaxOccurs = Once;
                    textelement(JibJmb)
                    {
                    }
                    textelement(Naziv)
                    {
                    }
                    textelement(DatumUpisa)
                    {
                    }
                    textelement(BrojUposlenih)
                    {
                    }
                    textelement(PeriodOd)
                    {
                    }
                    textelement(PeriodDo)
                    {
                    }
                    textelement(SifraDjelatnosti)
                    {
                    }
                }
                textelement(Dio2)
                {
                    MaxOccurs = Once;
                    tableelement(Table5200; Employee)
                    {
                        MaxOccurs = Unbounded;
                        MinOccurs = Once;
                        XmlName = 'PodaciOPrihodima';
                        SourceTableView = sorting("No.") order(descending) where("Contribution Category Code" = filter(('FBIH|FBIHRS')));

                        //ĐK SourceTableView = WHERE("Contribution Category Code"=FILTER(FBIH|FBIHRS));
                        textelement(VrstaIsplate)
                        {

                            trigger OnBeforePassVariable()
                            begin


                                WageCalc2.SETFILTER("Employee No.", WageCalc."Employee No.");
                                WageCalc2.SETFILTER("Month Of Wage", '%1', WageCalc."Month Of Wage");
                                WageCalc2.SETFILTER("Year of Wage", '%1', WageCalc."Year of Wage");
                                IF WageCalc2.FINDFIRST THEN BEGIN
                                    WageCalc2.CALCFIELDS(Use);
                                    IF WageCalc2.Use <> 0 THEN BEGIN
                                        PaymentTypeRecord.SETFILTER("Version Code", '%1', '2');
                                        IF PaymentTypeRecord.FINDFIRST THEN
                                            VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                    END

                                    ELSE
                                        IF WageCalc2.Use = 0 THEN BEGIN

                                            PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                            IF PaymentTypeRecord.FINDFIRST THEN
                                                VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");

                                            POR80 := 0;
                                            EmpAbs.RESET;
                                            EmpAbs.SETFILTER("Employee No.", WageCalc."Employee No.");
                                            IF EmpAbs.FIND('-') THEN BEGIN
                                                StartDateD := DMY2DATE(1, Month, Year);
                                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                                EmpAbs.SETRANGE("From Date", StartDateD, EndDateD);
                                                EmpAbs.SETRANGE("Cause of Absence Code", 'POR-80');
                                                EmpAbs.CALCSUMS(Quantity);
                                                POR80 += EmpAbs.Quantity;
                                                IF ((POR80 < WageCalc."Hour Pool") AND (POR80 <> 0)) THEN BEGIN
                                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                    IF PaymentTypeRecord.FINDFIRST THEN
                                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                                END;
                                            END;

                                            BOL := 0;
                                            EmpAbs1.RESET;
                                            EmpAbs1.SETFILTER("Employee No.", WageCalc."Employee No.");
                                            IF EmpAbs1.FIND('-') THEN BEGIN
                                                StartDateD := DMY2DATE(1, Month, Year);
                                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                                EmpAbs1.SETRANGE("From Date", StartDateD, EndDateD);
                                                EmpAbs1.SETRANGE("Cause of Absence Code", 'BOL-100');
                                                EmpAbs1.CALCSUMS(Quantity);
                                                BOL += EmpAbs1.Quantity;
                                                IF BOL <> 0 THEN BEGIN
                                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '1');
                                                    IF PaymentTypeRecord.FINDFIRST THEN
                                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                                END;
                                            END;


                                            BOL42 := 0;
                                            EmpAbs2.RESET;
                                            EmpAbs2.SETFILTER("Employee No.", WageCalc."Employee No.");
                                            IF EmpAbs2.FIND('-') THEN BEGIN
                                                StartDateD := DMY2DATE(1, Month, Year);
                                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                                EmpAbs2.SETRANGE("From Date", StartDateD, EndDateD);
                                                EmpAbs2.SETRANGE("Cause of Absence Code", 'BOL-42');
                                                EmpAbs2.CALCSUMS(Quantity);
                                                BOL42 := EmpAbs2.Quantity;
                                                IF BOL42 <> 0 THEN BEGIN
                                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '10');
                                                    IF PaymentTypeRecord.FINDFIRST THEN
                                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                                END;
                                            END;


                                            POR70 := 0;
                                            EmpAbs3.RESET;
                                            EmpAbs3.SETFILTER("Employee No.", WageCalc."Employee No.");
                                            IF EmpAbs3.FIND('-') THEN BEGIN
                                                StartDateD := DMY2DATE(1, Month, Year);
                                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                                EmpAbs3.SETRANGE("From Date", StartDateD, EndDateD);
                                                EmpAbs3.SETRANGE("Cause of Absence Code", 'POR-70');
                                                EmpAbs3.CALCSUMS(Quantity);
                                                POR70 := EmpAbs3.Quantity;
                                                IF POR70 <> 0 THEN BEGIN
                                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '3');
                                                    IF PaymentTypeRecord.FINDFIRST THEN
                                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                                END;
                                            END;

                                            BOL42100 := 0;
                                            EmpAbs4.RESET;
                                            EmpAbs4.SETFILTER("Employee No.", WageCalc."Employee No.");
                                            IF EmpAbs4.FIND('-') THEN BEGIN
                                                StartDateD := DMY2DATE(1, Month, Year);
                                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                                EmpAbs4.SETRANGE("From Date", StartDateD, EndDateD);
                                                EmpAbs4.SETRANGE("Cause of Absence Code", 'BOL-42-100');
                                                EmpAbs4.CALCSUMS(Quantity);
                                                BOL42100 := EmpAbs4.Quantity;
                                                IF BOL42100 <> 0 THEN BEGIN
                                                    PaymentTypeRecord.SETFILTER("Version Code", '%1', '5');
                                                    IF PaymentTypeRecord.FINDFIRST THEN
                                                        VrstaIsplate := FORMAT(PaymentTypeRecord."Level Code");
                                                END;
                                            END;
                                            IF VrstaIsplate = '0' THEN VrstaIsplate := '1';
                                        END;
                                END;
                            end;
                        }
                        textelement(Jmb)
                        {
                        }
                        textelement(ImePrezime)
                        {
                            MaxOccurs = Once;
                        }
                        textelement(DatumIsplate)
                        {
                        }
                        textelement(RadniSati)
                        {
                        }
                        textelement(RadniSatiBolovanje)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                SickHourPool := 0;
                                EA.SETFILTER("Employee No.", WageCalc."Employee No.");
                                IF EA.FIND('-') THEN
                                    StartDateD := DMY2DATE(1, IDMonth, IDYear);
                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));

                                EA.SETRANGE("From Date", StartDateD, EndDateD);
                                COA.SETRANGE("Sick Leave", TRUE);
                                COA.SETRANGE("No Report", FALSE);
                                IF COA.FIND('-') THEN
                                    REPEAT
                                        EA.SETRANGE("Cause of Absence Code", COA.Code);
                                        EA.CALCSUMS(Quantity);
                                        SickHourPool += EA.Quantity;
                                    UNTIL COA.NEXT = 0;
                                RadniSatiBolovanje := FORMAT(SickHourPool);
                            end;
                        }
                        textelement(BrutoPlaca)
                        {
                        }
                        textelement(KoristiIDrugiOporeziviPrihodi)
                        {
                        }
                        textelement(UkupanPrihod)
                        {
                        }
                        textelement(IznosPIO)
                        {
                        }
                        textelement(IznosZO)
                        {
                        }
                        textelement(IznosNezaposlenost)
                        {
                        }
                        textelement(doprinosi)
                        {
                            XmlName = 'Doprinosi';
                        }
                        textelement(PrihodUmanjenZaDoprinose)
                        {
                        }
                        textelement(FaktorLicnogOdbitka)
                        {
                        }
                        textelement(IznosLicnogOdbitka)
                        {
                        }
                        textelement(OsnovicaPoreza)
                        {
                        }
                        textelement(IznosPoreza)
                        {
                        }
                        textelement(RadniSatiUT)
                        {
                        }
                        textelement(StepenUvecanja)
                        {
                        }
                        textelement(SifraRadnogMjestaUT)
                        {
                        }
                        textelement(DoprinosiPIOMIOzaUT)
                        {
                        }
                        textelement(BeneficiraniStaz)
                        {
                        }
                        textelement(OpcinaPrebivalista)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            WC2.RESET;
                            WC2.SETRANGE("Month Of Wage", Month);
                            WC2.SETRANGE("Year of Wage", Year);
                            WC2.SETFILTER("Employee No.", Table5200."No.");
                            WC2.SETFILTER("Wage Calculation Type", '%1', 0);
                            IF WC2.FINDFIRST THEN BEGIN
                                ImePrezime := FORMAT(Table5200."First Name") + ' ' + FORMAT(Table5200."Last Name");
                                IF Table5200."Contribution Category Code" = 'FBIHRS' THEN BEGIN
                                    WageSetup.GET;
                                    OpcinaPrebivalista := WageSetup."RS Municipality Code";
                                END
                                ELSE
                                    OpcinaPrebivalista := Table5200."Municipality Code";
                                //   Brojac +=1;

                                Jmb := Table5200."Employee ID";
                                StepenUvecanja := '';
                            END
                            ELSE
                                currXMLport.SKIP;
                            WageCalc.SETRANGE("Month Of Wage", Month);
                            WageCalc.SETRANGE("Year of Wage", Year);
                            WageCalc.SETFILTER("Employee No.", Table5200."No.");
                            WageCalc.SETFILTER("Wage Calculation Type", '%1', 0);
                            WageCalc.SETFILTER("Contribution Category Code", '%1|%2', 'FBIH', 'FBIHRS');

                            Bruto := 0;
                            Tax := 0;
                            TaxBasis := 0;
                            TaxDed := 0;
                            Net := 0;
                            IndirectBrutto := 0;
                            SickHourPool := 0;
                            TotalNezapIZ := 0;
                            TotalPIO := 0;
                            TotalZOiz := 0;
                            TotalNezapU := 0;
                            TotalPioNa := 0;
                            TotalZOna := 0;

                            EA.RESET;
                            EA.SETFILTER("Employee No.", Table5200."No.");
                            IF EA.FIND('-') THEN BEGIN
                                StartDateD := DMY2DATE(1, Month, Year);
                                EndDateD := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDateD));
                                EA.SETRANGE("From Date", StartDateD, EndDateD);
                                COA.SETRANGE("Sick Leave", TRUE);
                                COA.SETRANGE("No Report", FALSE);
                                IF COA.FIND('-') THEN
                                    REPEAT
                                        EA.SETRANGE("Cause of Absence Code", COA.Code);
                                        EA.CALCSUMS(Quantity);
                                        SickHourPool += EA.Quantity;
                                    UNTIL COA.NEXT = 0;
                            END;
                            RadniSatiBolovanje := FORMAT(SickHourPool, 0, '<Precision,2:2><Standard Format,2>');
                            // RadniSatiBolovanje:=decimale2(RadniSatiBolovanje);


                            GetAddTaxesPercentage(AddTaxPerc);
                            InvTaxPerc1 := 0;
                            TaxClass.RESET;
                            TaxClass.SETFILTER(Active, '%1', TRUE);
                            TaxClass.SETFILTER(Code, '%1', 'FBIH');
                            IF TaxClass.FIND('-') THEN
                                InvTaxPerc1 := 1 - TaxClass.Percentage / 100;


                            IF WageCalc.FINDFIRST THEN BEGIN
                                WageCalc.CALCFIELDS(Use);
                                TaxDed := WageCalc."Tax Deductions";
                                COdbitak += WageCalc."Tax Deductions";
                                RadniSati := FORMAT(WageCalc."Individual Hour Pool" - WageCalc."Unpaid Absence Hours");
                                /*ContributionPerEmployee.RESET;
                                ContributionPerEmployee.SETFILTER("Wage Header No.",WageCalc."Wage Header No.");
                                ContributionPerEmployee.SETFILTER("Employee No.",WageCalc."Employee No.");
                                ContributionPerEmployee.SETFILTER("Contribution Code",'D-PIO-IZ');
                                IF ContributionPerEmployee.FINDFIRST THEN REPEAT
                                  TotalPIO+=ContributionPerEmployee."Amount From Wage";
                                UNTIL ContributionPerEmployee.NEXT=0;

                                ContributionPerEmployeeZdravstvo.RESET;
                                ContributionPerEmployeeZdravstvo.SETFILTER("Wage Header No.",WageCalc."Wage Header No.");
                                ContributionPerEmployeeZdravstvo.SETFILTER("Employee No.",WageCalc."Employee No.");
                                ContributionPerEmployeeZdravstvo.SETFILTER("Contribution Code",'D-ZDRAV-IZ');
                                IF ContributionPerEmployeeZdravstvo.FINDFIRST THEN REPEAT
                                  TotalZOiz+=ContributionPerEmployeeZdravstvo."Amount From Wage";
                                UNTIL ContributionPerEmployeeZdravstvo.NEXT=0;

                                ContributionPerEmployeeNezaposlenost.RESET;
                                ContributionPerEmployeeNezaposlenost.SETFILTER("Wage Header No.",WageCalc."Wage Header No.");
                                ContributionPerEmployeeNezaposlenost.SETFILTER("Employee No.",WageCalc."Employee No.");
                                ContributionPerEmployeeNezaposlenost.SETFILTER("Contribution Code",'D-NEZAP-IZ');
                                IF ContributionPerEmployeeNezaposlenost.FINDFIRST THEN REPEAT
                                  TotalNezapIZ+=ContributionPerEmployeeNezaposlenost."Amount From Wage";
                                UNTIL ContributionPerEmployeeNezaposlenost.NEXT=0;*/

                                REPEAT
                                    IndirectBrutto += WageCalc.Use;///((1-AddTaxPerc/100)*InvTaxPerc1);
                                    DirectBrutto += WageCalc.Brutto - IndirectBrutto;
                                    TaxBasis += WageCalc."Tax Basis";
                                    Bruto += WageCalc.Brutto;
                                    Tax += WageCalc.Tax;

                                    Net += WageCalc."Net Wage";
                                UNTIL WageCalc.NEXT = 0;
                            END;

                            DatumIsplateT := FORMAT(WageCalc."Payment Date");
                            DatumIsplate := '20' + COPYSTR(DatumIsplateT, 7, 2) + '-' + COPYSTR(DatumIsplateT, 4, 2) + '-' + COPYSTR(DatumIsplateT, 1, 2);
                            RadniSati := decimale2(RadniSati);
                            DirectBrutto := Bruto - IndirectBrutto;
                            BrutoPlaca := FORMAT(ROUND(DirectBrutto, 0.01));
                            BrutoPlaca := decimale2(BrutoPlaca);

                            KoristiIDrugiOporeziviPrihodi := FORMAT(ROUND(IndirectBrutto, 0.01));
                            KoristiIDrugiOporeziviPrihodi := decimale2(KoristiIDrugiOporeziviPrihodi);

                            ZPrihod := ROUND(DirectBrutto, 0.01) + ROUND(IndirectBrutto, 0.01);
                            UkupanPrihod := FORMAT(ROUND(ZPrihod, 0.01), 0, '<Standard Format,2>');
                            UkupanPrihod := FORMAT(ROUND(ZPrihod, 0.01));
                            UkupanPrihod := decimale2(UkupanPrihod);
                            CPrihod += ZPrihod;
                            FaktorLicnogOdbitkaDecimal := TaxDed / 300;
                            FaktorLicnogOdbitka := FORMAT(ROUND(FaktorLicnogOdbitkaDecimal, 0.01), 0, '<Precision,3:3><Standard Format,2>');
                            // FaktorLicnogOdbitka:=FORMAT(ROUND(FaktorLicnogOdbitkaDecimal,0.01));
                            // FaktorLicnogOdbitka:=decimale2(FaktorLicnogOdbitka);
                            ZOdbitak := 0;
                            ZOdbitak := TaxDed;
                            IznosLicnogOdbitka := FORMAT(ROUND(ZOdbitak, 0.01));
                            IznosLicnogOdbitka := decimale2(IznosLicnogOdbitka);

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');

                            IF ConCatConn.FINDFIRST THEN
                                TotalPIO += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');

                            IF ConCatConn.FINDFIRST THEN
                                TotalZOiz += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-NEZAP-IZ');
                            IF ConCatConn.FINDFIRST THEN
                                TotalNezapIZ += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            IznosPIO := FORMAT(ROUND(TotalPIO, 0.01));
                            IznosPIO := decimale2(IznosPIO);

                            IznosZO := FORMAT(ROUND(TotalZOiz, 0.01));
                            IznosZO := decimale2(IznosZO);

                            IznosNezaposlenost := FORMAT(ROUND(TotalNezapIZ, 0.01));
                            IznosNezaposlenost := decimale2(IznosNezaposlenost);

                            ZDoprinos := TotalPIO + TotalZOiz + TotalNezapIZ;
                            Doprinosi := FORMAT(ROUND(ZDoprinos, 0.01));
                            Doprinosi := decimale2(Doprinosi);
                            CDoprinos += ZDoprinos;

                            PrihodUmanjenZaDoprinose := FORMAT(ROUND(Net, 0.01));
                            PrihodUmanjenZaDoprinose := decimale2(PrihodUmanjenZaDoprinose);

                            OsnovicaPoreza := FORMAT(ROUND(TaxBasis, 0.01));
                            OsnovicaPoreza := decimale2(OsnovicaPoreza);

                            IznosPoreza := FORMAT(ROUND(Tax, 0.01));
                            IznosPoreza := decimale2(IznosPoreza);
                            Porez1 += ROUND(TaxBasis * 0.1, 0.01);

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');

                            IF ConCatConn.FINDFIRST THEN
                                PIOOn += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-NA');

                            IF ConCatConn.FINDFIRST THEN
                                ZOOn += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            ConCatConn.RESET;
                            ConCatConn.SETFILTER("Category Code", '%1', WageCalc."Contribution Category Code");
                            ConCatConn.SETFILTER("Contribution Code", '%1', 'D-NEZAP-NA');
                            IF ConCatConn.FINDFIRST THEN
                                UnempOn += (WageCalc.Brutto * ConCatConn.Percentage) / 100;

                            RadniSatiUT := '0.00';
                            //  StepenUvecanja :='0';
                            SifraRadnogMjestaUT := '000000';
                            DoprinosiPIOMIOzaUT := '0.00';
                            BeneficiraniStaz := 'false';

                        end;

                        trigger OnPreXmlItem()
                        begin
                            Table5200.SETCURRENTKEY("Last Name", "First Name");
                        end;
                    }
                }
                textelement(Dio3)
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    textelement(PIO)
                    {
                    }
                    textelement(ZO)
                    {
                    }
                    textelement(OsiguranjeOdNezaposlenosti)
                    {
                    }
                    textelement(DodatniDoprinosiZO)
                    {
                    }
                    textelement(Prihod)
                    {
                    }
                    textelement(doprinosi1)
                    {
                        XmlName = 'Doprinosi';
                    }
                    textelement(LicniOdbici)
                    {
                    }
                    textelement(Porez)
                    {
                    }

                    trigger OnBeforePassVariable()
                    begin
                        PIO := FORMAT(ROUND(PIOOn, 0.01));
                        PIO := decimale2(PIO);

                        ZO := FORMAT(ROUND(ZOOn, 0.01));
                        ZO := decimale2(ZO);

                        OsiguranjeOdNezaposlenosti := FORMAT(ROUND(UnempOn, 0.01));
                        OsiguranjeOdNezaposlenosti := decimale2(OsiguranjeOdNezaposlenosti);

                        DodatniDoprinosiZO := '0.00';

                        Prihod := FORMAT(ROUND(CPrihod, 0.01));
                        Prihod := decimale2(Prihod);

                        Doprinosi1 := FORMAT(ROUND(CDoprinos, 0.01));
                        Doprinosi1 := decimale2(Doprinosi1);

                        LicniOdbici := FORMAT(ROUND(COdbitak, 0.01));
                        LicniOdbici := decimale2(LicniOdbici);

                        Porez := FORMAT(ROUND(Porez1, 0.01));
                        Porez := decimale2(Porez);
                    end;
                }
                tableelement("<company information2>"; "Company Information")
                {
                    MaxOccurs = Once;
                    MinOccurs = Zero;
                    XmlName = 'Dio4IzjavaPoslodavca';
                    textelement(JibJmbPoslodavca)
                    {
                    }
                    textelement(DatumUnosa)
                    {
                    }
                    textelement(nazivposlodavca1)
                    {
                        XmlName = 'NazivPoslodavca';
                    }

                    trigger OnAfterGetRecord()
                    begin
                        JibJmbPoslodavca := Table79."Registration No.";
                        NazivPoslodavca1 := Table79.Name;
                        DatumUnosa := '20' + COPYSTR(DatumPodnosenjaT, 7, 2) + '-' + COPYSTR(DatumPodnosenjaT, 4, 2) + '-' + COPYSTR(DatumPodnosenjaT, 1, 2);
                        Operacija := 'Prijava_od_strane_poreznog_obveznika';
                    end;
                }
                textelement(Dokument)
                {
                    MaxOccurs = Once;
                    textelement(Operacija)
                    {
                    }
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(Mjesec; Month)
                {
                }
                field(Godina; Year)
                {
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        Month := DATE2DMY(TODAY, 2);
        Year := DATE2DMY(TODAY, 3);
    end;

    trigger OnPreXmlPort()
    begin
        CompInfo.GET;

        //IDMonth:=XMLWageCalc."Month Of Wage";
        //IDYear:=XMLWageCalc."Year Of Wage";
    end;

    var
        xwc: Record "XML Wage Calculation";
        EA: Record "Employee Absence";
        EMPL: Record Employee;
        TempCalc: Record "Tax Class";
        IDMonth: Integer;
        IDYear: Integer;
        IDMonthText: Text[10];
        TotalNezapIZ: Decimal;
        TotalPIO: Decimal;
        TotalZOiz: Decimal;
        TotalNezapU: Decimal;
        TotalTax: Decimal;
        TotalPioNa: Decimal;
        TotalZOna: Decimal;
        TaxClass: Record "Tax Class";
        CompInfo: Record "Company Information";
        AddTaxPerc: Decimal;
        COA: Record "Cause of Absence";
        StartDateD: Date;
        EndDateD: Date;
        StartDateT: Text[2];
        EndDateT: Text[2];
        Godina: Text[30];
        Brojac: Integer;
        IndirectBrutto: Decimal;
        InvTaxPerc1: Decimal;
        DirectBrutto: Decimal;
        SickHourPool: Decimal;
        CPE: Record "Contribution Per Employee";
        BrZapos: Integer;
        PeriodOdT: Text[30];
        PeriodDoT: Text[30];
        DatumIsplateT: Text[30];
        FaktorLicnogOdbitkaDecimal: Decimal;
        schemaLocation: Text[100];
        DatumPodnosenjaT: Text[30];
        counter: Integer;
        XMLWageCalc: Record "XML Wage Calculation";
        PIOOn: Decimal;
        ZOOn: Decimal;
        UnempOn: Decimal;
        ZDoprinos: Decimal;
        CDoprinos: Decimal;
        ZPrihod: Decimal;
        CPrihod: Decimal;
        COdbitak: Decimal;
        ZOdbitak: Decimal;
        Porez1: Decimal;
        Timestamp1: Date;
        Timestamp2: Date;
        ContributionPerEmployee: Record "Contribution Per Employee";
        ContributionPerEmployeeZdravstvo: Record "Contribution Per Employee";
        ContributionPerEmployeeNezaposlenost: Record "Contribution Per Employee";
        Month: Integer;
        Year: Integer;
        WC: Record "Wage Calculation";
        Tax: Decimal;
        TaxBasis: Decimal;
        Bruto: Decimal;
        TaxDed: Decimal;
        Net: Decimal;
        ConCatConn: Record "Contribution Category Conn.";
        WC2: Record "Wage Calculation";
        WC1: Record "Wage Calculation";
        WageCalc: Record "Wage Calculation";
        PaymentType: Integer;
        PaymentTypeRecord: Record "Where-Used Line";
        EmpAbs: Record "Employee Absence";
        POR80: Integer;
        BOL: Integer;
        EmpAbs1: Record "Employee Absence";
        BOL42: Integer;
        EmpAbs2: Record "Employee Absence";
        EmpAbs3: Record "Employee Absence";
        POR70: Integer;
        WageCalc2: Record "Wage Calculation";
        WageSetup: Record "Wage Setup";
        BOL42100: Integer;
        EmpAbs4: Record "Employee Absence";

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    var
        AddTaxes: Record "Contribution";
        ATCCon: Record "Contribution Category Conn.";
    begin
        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        IF AddTaxes.FIND('-') THEN
            REPEAT
                IF ATCCon.GET('FBIH', AddTaxes.Code) THEN
                    Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;

    procedure decimale2(opis: Text[30]) ukupno1: Text[30]
    var
        c1: Text[30];
        c2: Text[30];
        d: Integer;
    begin
        opis := DELCHR(opis, '=', '.');
        d := STRLEN(opis);

        IF opis = '0' THEN
            ukupno1 := opis + '.00'
        ELSE
            IF STRPOS(opis, '.') = (d - 1) THEN BEGIN
                c1 := COPYSTR(opis, 1, d - 1);
                c2 := COPYSTR(opis, d, 1);
                ukupno1 := c1 + '.' + c2 + '0';
            END
            ELSE
                IF STRPOS(opis, '.') = (d - 2) THEN BEGIN
                    IF STRPOS(opis, '.') <> 0 THEN BEGIN
                        c1 := COPYSTR(opis, 1, d - 3);
                        c2 := COPYSTR(opis, d - 1, 2);
                        ukupno1 := c1 + '.' + c2;
                    END
                    ELSE
                        ukupno1 := opis + '.00'
                END
                ELSE
                    IF STRPOS(opis, ',') = (d - 1) THEN BEGIN
                        c1 := COPYSTR(opis, 1, d - 2);
                        c2 := COPYSTR(opis, d, 1);
                        ukupno1 := c1 + '.' + c2 + '0';
                    END
                    ELSE
                        IF STRPOS(opis, ',') = (d - 2) THEN BEGIN
                            IF STRPOS(opis, ',') <> 0 THEN BEGIN
                                c1 := COPYSTR(opis, 1, d - 3);
                                c2 := COPYSTR(opis, d - 1, 2);
                                ukupno1 := c1 + '.' + c2;
                            END
                            ELSE
                                ukupno1 := opis + '.00';
                        END
                        ELSE
                            ukupno1 := opis + '.00';
    end;

    procedure decimale(description: Text[30]) ukupno: Text[30]
    var
        b1: Text[30];
        b2: Text[30];
    begin
        IF STRLEN(description) = 1 THEN
            ukupno := description + '.000'
        ELSE
            IF STRLEN(description) = 3 THEN
                IF STRPOS(description, ',') = 2 THEN BEGIN
                    b1 := COPYSTR(description, 1, 1);
                    b2 := COPYSTR(description, 3, 1);
                    ukupno := b1 + '.' + b2 + '00';
                END
                ELSE
                    IF STRPOS(description, '.') = 2 THEN BEGIN
                        ukupno := description + '00';
                    END;
    end;
}

