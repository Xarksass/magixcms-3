{extends file="tinymce/layout.tpl"}
{block name="head:title"}Search CMS pages{/block}
{block name="head:script"}pages/mc_pages.js{/block}
{block name="main:content"}
    <div class="container">
        <div id="template-container">
            <form action="#" class="validate_form">
                {include file="language/brick/dropdown-lang.tpl" label=false onclass=true}
                <div class="tab-content">
                    {foreach $langs as $id => $iso}
                        <fieldset role="tabpanel" class="tab-pane lang-{$id}{if $iso@first} active{/if}">
                            <h2>Ajouter un lien</h2>
                            <div class="form-group">
                                <div id="{$iso['iso']}pages" class="btn-group btn-block selectpicker" data-clear="true" data-live="true">
                                    <a href="#" class="clear"><span class="fas fa-times"></span><span class="sr-only">Annuler la sélection</span></a>
                                    <button data-id="parent" type="button" class="btn btn-block btn-default dropdown-toggle">
                                        <span class="placeholder">Choississez un lien à ajouter</span>
                                        <span class="caret"></span>
                                    </button>
                                    <div class="dropdown-menu">
                                        <div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
                                            <label class="sr-only" for="input-pages">Rechercher dans la liste</label>
                                            <div class="search-box">
                                                <div class="input-group">
													<span class="input-group-addon" id="search-pages">
														<span class="fa fa-search"></span>
														<a href="#" class="fa fa-times hide filter-clear"><span class="sr-only">Effacer filtre</span></a>
													</span>
                                                    <input type="text" placeholder="Rechercher dans la liste" id="input-pages" class="form-control live-search" aria-describedby="search-pages" tabindex="1" />
                                                </div>
                                            </div>
                                            <div id="filter-pages" class="list-to-filter tree-display">
                                                <ul class="list-unstyled">
                                                    {include file="tinymce/loop/link-list.tpl" data=$pages[$id] type='pages'}
                                                </ul>
                                                <div class="no-search-results">
                                                    <div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>Aucune entrée pour <strong>'<span></span>'</strong> n'a été trouvée.</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <input type="hidden" name="{$iso['iso']}pages_id" id="{$iso['iso']}pages_id" class="form-control pages_id" value="" data-lang="{$iso['iso']}"/>
                            </div>
                        </fieldset>
                    {/foreach}
                </div>
            </form>
            <form id="pages-link" action="#" method="post" class="validate_form collapse">
                <div class="form-group">
                    <label for="text">Texte affiché</label>
                    <input type="text" id="text" class="form-control required" placeholder="Texte affiché" required/>
                </div>
                <div class="form-group">
                    <label for="title">Libellé du lien</label>
                    <input type="text" id="title" class="form-control required" placeholder="Texte au survol" required/>
                </div>
                <div class="form-group">
                    <label for="url">URL du lien</label>
                    <input type="text" id="url" class="form-control required" value="" readonly required/>
                </div>
                <div class="form-group">
                    <label for="blank">Ouvrir le lien dans un nouvel onglet</label>
                    <div class="switch">
                        <input type="checkbox" id="blank" class="switch-native-control" />
                        <div class="switch-bg">
                            <div class="switch-knob"></div>
                        </div>
                    </div>
                </div>
                <button type="submit" class="btn btn-main-theme">Insérer le lien</button>
            </form>
        </div>
    </div>
{/block}