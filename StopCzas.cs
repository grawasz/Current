        [Category("Komunikaty SCK")]
        [Description("Dzień i godzina ostatniego zdarzenia, zapisanego w dzienniku")]
        [DisplayName("Godzina ostatniego zdarzenia")]
        public DateTime KomunikatySCKStopCzas
        {
            get => _komunikatySCKStopCzas;
            set
            {
                this._komunikatySCKStopCzas = value;
                this._localConfig["KomunikatySCKStopCzas"] = string.Format("{0:yyyy-MM-dd HH:mm}", this._komunikatySCKStopCzas);
            }
        }

        [Category("Raport faktur wystawionych")]
        [Description("Dzień i godzina ostatniego zdarzenia, zapisanego w dzienniku")]
        [DisplayName("Godzina ostatniego zdarzenia")]
        public DateTime FakturyWystawioneStopCzas
        {
            get => _fakturyWystawioneStopCzas;
            set
            {
                this._fakturyWystawioneStopCzas = value;
                this._localConfig["FakturyWystawioneStopCzas"] = string.Format("{0:yyyy-MM-dd HH:mm}", this._fakturyWystawioneStopCzas);
            }
        }

        [Category("Faktury rabatowe")]
        [Description("Dzień i godzina ostatniego zdarzenia, zapisanego w dzienniku")]
        [DisplayName("Godzina ostatniego zdarzenia")]
        public DateTime FakturyRabatoweStopCzas
        {
            get => _fakturyRabatoweStopCzas;
            set
            {
                this._fakturyRabatoweStopCzas = value;
                this._localConfig["FakturyRabatoweStopCzas"] = string.Format("{0:yyyy-MM-dd HH:mm}", this._fakturyRabatoweStopCzas);
            }
        }

        [Category("Korekty zawinione")]
        [Description("Dzień i godzina ostatniego zdarzenia, zapisanego w dzienniku")]
        [DisplayName("Godzina ostatniego zdarzenia")]
        public DateTime KorektyZawinioneStopCzas
        {
            get => _korektyZawinioneStopCzas;
            set
            {
                this._korektyZawinioneStopCzas = value;
                this._localConfig["KorektyZawinioneStopCzas"] = string.Format("{0:yyyy-MM-dd HH:mm}", this._korektyZawinioneStopCzas);
            }
        }

        [Category("Program wsparcia")]
        [Description("Dzień i godzina ostatniego zdarzenia, zapisanego w dzienniku")]
        [DisplayName("Godzina ostatniego zdarzenia")]
        public DateTime ProgramWsparciaStopCzas
        {
            get => _programWsparciaStopCzas;
            set
            {
                this._programWsparciaStopCzas = value;
                this._localConfig["ProgramWsparciaStopCzas"] = string.Format("{0:yyyy-MM-dd HH:mm}", this._programWsparciaStopCzas);
            }
        }


        private DateTime _komunikatySCKStopCzas;       
        private DateTime _fakturyWystawioneStopCzas;
        private DateTime _fakturyRabatoweStopCzas;
        private DateTime _korektyZawinioneStopCzas;
        private DateTime _programWsparciaStopCzas;
        
        DateTime.TryParse(this._localConfig["FakturyRabatoweStopCzas"], out this._fakturyRabatoweStopCzas);
            DateTime.TryParse(this._localConfig["FakturyWystawioneStopCzas"], out this._fakturyWystawioneStopCzas);
            DateTime.TryParse(this._localConfig["KomunikatySCKStopCzas"], out this._komunikatySCKStopCzas);
            DateTime.TryParse(this._localConfig["KorektyZawinioneStopCzas"], out this._korektyZawinioneStopCzas);
            DateTime.TryParse(this._localConfig["ProgramWsparciaStopCzas"], out this._programWsparciaStopCzas);


